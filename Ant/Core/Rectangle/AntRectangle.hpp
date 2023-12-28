#pragma once

#include "BorderConfig.hpp"
#include <QPainter>
#include <QQuickItem>
#include <QQuickPaintedItem>
namespace Ant {
class AntRectangle : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(BorderConfig* border READ border)
    CREATE_QML_PROPERTY(QColor, color, Color, Qt::GlobalColor::gray)

public:
    AntRectangle(QQuickItem* parent = nullptr);

    BorderConfig* border() { return &borderM; }

    void paint(QPainter* painter) override;

signals:
    void borderWidthChanged();
    void radiusChanged();

private:
    QPainterPath getBoundPath(qreal topLeftRadius, qreal topRightRadius, qreal bottomLeftRadius, qreal bottomRightRadius);
    void drawBorder(QPainter* painter, const QPainterPath& path);
    void drawBackground(QPainter* painter);

    BorderConfig borderM{};
};
}
