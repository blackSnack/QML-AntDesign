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
#include "AntListModel.hpp"

#include <QDebug>

namespace Ant {
AntListModel::AntListModel(QObject* parent) : QAbstractListModel{ parent } {}

int AntListModel::rowCount(const QModelIndex& parent) const
{
    if (parent.isValid())
    {
        return 0;
    }
    return hasSourceModel() ? sourceModel()->rowCount(parent) : valuesM.length();
}

QVariant AntListModel::data(const QModelIndex& index, int role) const
{
    // qDebug() << __FUNCTION__ << index << role;
    if (!index.isValid() || index.row() < 0 || index.row() >= rowCount())
    {
        return QVariant{};
    }

    return getData(index, role);
}

QHash<int, QByteArray> AntListModel::roleNames() const
{
    return hasSourceModel() ? sourceModel()->roleNames() : QHash<int, QByteArray>{
        { Qt::DisplayRole, "display" },
        { LabelRole, "label" },
        { ValueRole, "value" },
        { ItemTypeRole, "type" },
        { IconRole, "icon" },
        { KeyRole, "key" },
        { ChildrenRole, "children" },
        { DisabledRole, "disabled" },
    };
}

void AntListModel::setValues(const QVariant& values)
{
    beginResetModel();
    bool isJsValue = values.canConvert<QJSValue>();
    bool isItemModel = values.canConvert<QAbstractItemModel*>();
    QVariantList result{};
    if (isJsValue)
    {
        result = parseValues(values.value<QJSValue>());
    }
    else if (isItemModel)
    {
        bindSourceModel(values.value<QAbstractItemModel*>());
    }else {
        result = parseValues(values.toList());
    }
    
    valuesM = result;
    endResetModel();
    emit valuesChanged();
}

QVariantList AntListModel::parseValues(const QJSValue& values)
{
    if (!values.isArray())
    {
        qWarning() << "Parse JS value error! Expected array[{label, value}]";
        return {};
    }
    return parseValues(values.toVariant().toList());
}

QVariantList AntListModel::parseValues(const QVariantList& values)
{
    QVariantList varList;
    for (const auto& var : values)
    {
        if (!var.canConvert<QVariantMap>())
        {
            qWarning() << "Value convert error! Expected QVariantMap" << var;
            continue;
        }
        varList.push_back(var.toMap());
    }
    return varList;
}

void AntListModel::bindSourceModel(QAbstractItemModel* model)
{
    unbindSourceModel();
    connect(model, &QAbstractItemModel::modelAboutToBeReset, this, &AntListModel::modelAboutToBeReset);
    connect(model, &QAbstractItemModel::modelReset, this, &AntListModel::modelReset);
    connect(model, &QAbstractItemModel::rowsInserted, this, &AntListModel::rowsInserted);
    connect(model, &QAbstractItemModel::rowsAboutToBeRemoved, this, &AntListModel::rowsAboutToBeRemoved);
    connect(model, &QAbstractItemModel::rowsRemoved, this, &AntListModel::rowsRemoved);
    connect(model, &QAbstractItemModel::dataChanged, this, &AntListModel::dataChanged);
    connect(model, &QAbstractItemModel::modelReset, this, &AntListModel::modelReset);
    sourceModelM = model;
}

void AntListModel::unbindSourceModel() 
{
    if (sourceModelM) 
    {
        disconnect(sourceModelM, &QAbstractItemModel::modelAboutToBeReset, this, &AntListModel::modelAboutToBeReset);
        disconnect(sourceModelM, &QAbstractItemModel::modelReset, this, &AntListModel::modelReset);
        disconnect(sourceModelM, &QAbstractItemModel::rowsInserted, this, &AntListModel::rowsInserted);
        disconnect(sourceModelM, &QAbstractItemModel::rowsAboutToBeRemoved, this, &AntListModel::rowsAboutToBeRemoved);
        disconnect(sourceModelM, &QAbstractItemModel::rowsRemoved, this, &AntListModel::rowsRemoved);
        disconnect(sourceModelM, &QAbstractItemModel::dataChanged, this, &AntListModel::dataChanged);
        disconnect(sourceModelM, &QAbstractItemModel::modelReset, this, &AntListModel::modelReset);
        sourceModelM = nullptr;
    }
}

QString AntListModel::roleToString(int role) const
{
    auto roles = roleNames();
    return roles.contains(role) ? roles[role] : QString{};
}

QVariant AntListModel::getData(const QModelIndex& index, int role) const
{
    if (hasSourceModel()) 
    {
        return sourceModel()->data(index, role);
    }

    auto mapValue = valuesM.at(index.row()).toMap();
    if (role == KeyRole || role == ValueRole)
    {
        auto keyValue = mapValue.value(roleToString(KeyRole));
        return keyValue.isValid() ? keyValue : mapValue.value(roleToString(ValueRole));
    }

    if (role == Qt::DisplayRole || role == LabelRole) 
    {
        auto displayValue = mapValue.value(roleToString(Qt::DisplayRole));
        return displayValue.isValid() ? displayValue : mapValue.value(roleToString(LabelRole));
    }

    return valuesM.at(index.row()).toMap().value(roleToString(role));
}

QVariant AntListModel::values() 
{
    if (hasSourceModel()) {
        QVariant sourceValues;
        QMetaObject::invokeMethod(sourceModel(), "values", Qt::BlockingQueuedConnection, Q_RETURN_ARG(QVariant, sourceValues));
        return sourceValues;
    }
    return valuesM; 
}

} // namespace Ant