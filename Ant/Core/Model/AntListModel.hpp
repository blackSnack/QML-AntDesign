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
#include <QAbstractListModel>
#include <QByteArray>
#include <QHash>
#include <QJSValue>
#include <QObject>

namespace Ant {
class AntListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QVariant values READ values WRITE setValues NOTIFY valuesChanged)
public:
    AntListModel(QObject* parent = nullptr);
    ~AntListModel() = default;

    enum
    {
        ValueRole = Qt::UserRole,
        LabelRole,
        DisabledRole,
        ItemTypeRole, // menu type. SubMenu, Item, Group
        IconRole,
        KeyRole,
        ChildrenRole,
    };
    
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariant values();
    void setValues(const QVariant& values);

signals:
    void valuesChanged();

private:
    bool hasSourceModel() const { return sourceModelM != nullptr; }

    QAbstractItemModel* sourceModel() const { return sourceModelM; }

    /// @brief parse values from QJSValue
    /// @param values QJSValue
    QVariantList parseValues(const QJSValue& values);

    /// @brief parse values from QVariant
    /// @param values QVariantList
    QVariantList parseValues(const QVariantList& values);

    QVariantList parseValues(const QAbstractItemModel* values);

    QString roleToString(int role) const;

    QVariant getData(const QModelIndex& index, int role) const;

    void bindSourceModel(QAbstractItemModel* model);
    void unbindSourceModel();

private:
    QVariantList valuesM{};
    QAbstractItemModel* sourceModelM {nullptr};
};

} // namespace Ant
