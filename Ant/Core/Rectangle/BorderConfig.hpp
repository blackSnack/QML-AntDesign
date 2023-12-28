#pragma once
// MIT License
// Copyright (c) 2023 Karl
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
#include "../../QmlHelper/QmlUtil.hpp"
#include <QColor>
#include <QObject>
#include <QQmlEngine>
#include <Qt>
namespace Ant
{
class BorderConfig : public QObject
{
    Q_OBJECT
    CREATE_QML_PROPERTY(qreal, width, Width)
    CREATE_QML_PROPERTY(QColor, color, Color, Qt::GlobalColor::transparent)
    CREATE_QML_PROPERTY(Qt::PenStyle, style, Style, Qt::PenStyle::SolidLine)
    CREATE_QML_PROPERTY(qreal, topLeftRadius, TopLeftRadius, 0.0)
    CREATE_QML_PROPERTY(qreal, topRightRadius, TopRightRadius, 0.0)
    CREATE_QML_PROPERTY(qreal, bottomLeftRadius, BottomLeftRadius, 0.0)
    CREATE_QML_PROPERTY(qreal, bottomRightRadius, BottomRightRadius, 0.0)
    CREATE_QML_PROPERTY(qreal, radius, Radius, 0.0)
public:
    explicit BorderConfig(QObject* parent = nullptr);

    bool hasCustomRadius() const
    {
        return topLeftRadiusM != 0.0 || topRightRadiusM != 0.0 || bottomLeftRadiusM != 0.0 || bottomRightRadiusM != 0.0;
    }
};
}
