#pragma once
// MIT License
// Copyright (c) 2024 Karl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
#include <QJSValue>
#include <QMetaObject>
#include <QMetaProperty>
#include <QObject>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQmlPropertyMap>

namespace Ant {

class ProxyJSValue : public QObject
{
    Q_OBJECT
public:
    ProxyJSValue() : QObject{} {}
    ProxyJSValue(QObject* item, const QJSValue& jsValue, QQmlContext* context) : QObject{}
    {
        Q_ASSERT(item);
        Q_ASSERT(context);
        Q_ASSERT(context->engine());
        auto engine = context->engine();
        auto jsModule = context->engine()->importModule(":/AntCore/LazyItemProxy/Proxy.js");

        if (jsModule.isError())
        {
            qWarning() << "Error creating proxy:" << jsModule.toString();
            return;
        }
        valueM = jsModule.property("createLazyProxy").call({ jsValue, engine->newQObject(item) });
    }

    QJSValue& jsValue() { return valueM; }
    ProxyJSValue& operator=(const ProxyJSValue& other)
    {
        valueM = other.valueM;
        return *this;
    }
    ~ProxyJSValue() = default;

private:
    QJSValue valueM;
};

class LazyItemProxy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* target READ target WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(QJSValue wapper READ wapper WRITE setWapper NOTIFY wapperChanged)
public:
    explicit LazyItemProxy(QObject* parent = nullptr) : QObject{ parent }
    {
        connect(this, &LazyItemProxy::targetChanged, this, &LazyItemProxy::syncWapper);
        connect(this, &LazyItemProxy::wapperChanged, this, &LazyItemProxy::syncWapper);
    }
    ~LazyItemProxy() {}

signals:
    void targetChanged();
    void wapperChanged();

public:
    QObject* target() { return targetM; }

    void setTarget(QObject* obj)
    {
        if (targetM != obj)
        {
            targetM = obj;
            emit targetChanged();
        }
    }

    QJSValue wapper() { return wapperM.jsValue(); }

    void setWapper(QJSValue obj)
    {
        if (!wapperM.jsValue().equals(obj))
        {
            wapperM = ProxyJSValue(this, obj, QQmlEngine::contextForObject(this));
            emit wapperChanged();
        }
    }

private slots:
    void syncWapper()
    {
        if (!targetM)
        {
            return;
        }

        syncProperty(targetM, wapperM.jsValue());
    }

private:
    bool isQObject(const QMetaProperty& property, QObject* target) { return property.read(target).value<QObject*>(); }

    void syncProperty(QObject* target, const QJSValue& jsValue)
    {
        if (!target)
        {
            return;
        }

        if (!jsValue.isObject() && !jsValue.isQObject())
        {
            qWarning() << "jsValue should be a Object to convert to QObject";
            return;
        }

        const QMetaObject* metaObject = target->metaObject();
        auto jsVar = jsValue.toVariant();

        if (jsValue.isQObject())
        {
            syncProperty(target, jsVar.value<QObject*>());
            return;
        }

        auto jsPropertyMap = jsVar.toMap();
        for (auto it = jsPropertyMap.cbegin(); it != jsPropertyMap.cend(); it++)
        {
            auto index = metaObject->indexOfProperty(it.key().toStdString().c_str());
            if (index == -1)
            {
                continue;
            }
            auto property = metaObject->property(index);
            auto propertyName = property.name();
            auto jsProperty = jsValue.property(propertyName);
            syncProperty(property, jsProperty, target);
        }
    }

    void syncProperty(QObject* target, QObject* origin)
    {
        Q_ASSERT(target && origin);

        const QMetaObject* targetMetaObj = target->metaObject();
        const QMetaObject* originMetaObj = origin->metaObject();

        for (int i = targetMetaObj->propertyOffset(); i < targetMetaObj->propertyCount(); ++i)
        {
            auto property = targetMetaObj->property(i);
            auto propertyName = property.name();
            auto originPropertyIndex = originMetaObj->indexOfProperty(propertyName);
            if (originPropertyIndex != -1)
            {
                auto originProperty = originMetaObj->property(originPropertyIndex);
                syncProperty(property, originProperty, target, origin);
            }
        }
    }

    void syncProperty(
        const QMetaProperty& targetProperty, const QMetaProperty& originProperty, QObject* target, QObject* origin)
    {
        bool targetProperyIsQObject = isQObject(targetProperty, target);
        bool originPropertyIsQObject = isQObject(originProperty, origin);
        if (targetProperyIsQObject && originPropertyIsQObject)
        {
            syncProperty(targetProperty.read(target).value<QObject*>(), originProperty.read(origin).value<QObject*>());
            return;
        }
        if (originPropertyIsQObject != targetProperyIsQObject)
        {
            qWarning() << "Origin property type different target property type!";
            return;
        }
        targetProperty.write(target, originProperty.read(origin));
    }

    void syncProperty(const QMetaProperty& property, const QJSValue& jsValue, QObject* target)
    {
        if (jsValue.isObject())
        {
            if (!jsValue.toQObject())
            {
                syncJsObject(property, jsValue, target);
            }
            else
            {
                syncQObject(property, jsValue.toQObject(), target);
            }
            return;
        }

        if (isQObject(property, target))
        {
            qWarning() << "The Property type different with JSValue!"
                       << "Property type is QObject. JSValue type is:" << jsValue.toVariant();
            return;
        }

        // direct write propertu to QProperty
        if (!property.write(target, jsValue.toVariant()))
        {
            qWarning() << "Write property faild! target:" << target->objectName() << "Property:" << property.name()
                       << jsValue.toVariant();
        }
    }

    void syncJsObject(const QMetaProperty& property, const QJSValue& jsValue, QObject* target)
    {
        Q_ASSERT(target);

        auto value = property.read(target);
        auto propertyObj = value.value<QObject*>();
        if (propertyObj)
        {
            syncProperty(propertyObj, jsValue);
            return;
        }

        // if the propertyObj is not initlized direct write data;
        property.write(target, jsValue.toVariant());
    }

    void syncQObject(const QMetaProperty& property, const QObject* object, QObject* target)
    {
        Q_ASSERT(object);
        Q_ASSERT(target);

        if (!isQObject(property, target))
        {
            qWarning() << "The Property type different with JSValue!"
                       << "Property type is not QObject. JSValue type is QObject";
        }
        syncProperty(property.read(target).value<QObject*>(), object);
    }

    QObject* targetM{ nullptr };
    ProxyJSValue wapperM{};
};

} // namespace Ant
