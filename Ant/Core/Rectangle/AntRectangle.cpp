#include "AntRectangle.hpp"

#include <QDebug>
#include <QPainterPath>

namespace Ant
{
AntRectangle::AntRectangle(QQuickItem* parent) : QQuickPaintedItem(parent)
{
    connect(&borderM, &BorderConfig::widthChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::colorChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::bottomLeftRadiusChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::bottomRightRadiusChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::topLeftRadiusChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::topRightRadiusChanged, this, &QQuickItem::update);
    connect(&borderM, &BorderConfig::radiusChanged, this, &QQuickItem::update);
    connect(this, &AntRectangle::colorChanged, this, &QQuickItem::update);
}

QPainterPath AntRectangle::getBoundPath(
    qreal topLeftRadius, qreal topRightRadius, qreal bottomLeftRadius, qreal bottomRightRadius)
{
    QPainterPath path;

    auto rect = boundingRect();
    auto offset = borderM.width();

    // inner offset border
    rect = rect.adjusted(offset, offset, -offset, -offset);

    auto maxRadius = std::min(HALF_F(rect.width()), HALF_F(rect.height()));
    auto tempTLRadius = std::min(maxRadius, topLeftRadius);
    auto tempTRRadius = std::min(maxRadius, topRightRadius);
    auto tempBRRadius = std::min(maxRadius, bottomRightRadius);
    auto tempBLRadius = std::min(maxRadius, bottomLeftRadius);

    QRectF topLeftRect{ rect.left(), rect.top(), DOUBLE_F(tempTLRadius), DOUBLE_F(tempTLRadius) };
    QRectF topRightRect{
        rect.right() - DOUBLE_F(tempTRRadius), rect.top(), DOUBLE_F(tempTRRadius), DOUBLE_F(tempTRRadius)
    };
    QRectF bottomRightRect{ rect.right() - DOUBLE_F(tempBRRadius),
        rect.bottom() - DOUBLE_F(tempBRRadius),
        DOUBLE_F(tempBRRadius),
        DOUBLE_F(tempBRRadius) };
    QRectF bottomLeftRect{
        rect.left(), rect.bottom() - DOUBLE_F(tempBLRadius), DOUBLE_F(tempBLRadius), DOUBLE_F(tempBLRadius)
    };

    // top left arc
    path.arcMoveTo(topLeftRect, 180);
    path.arcTo(topLeftRect, 180, -90);

    // line to top right
    path.lineTo(topRightRect.topLeft().x() + tempTRRadius, topRightRect.topLeft().y());

    // top right right
    // path.arcMoveTo(topRightRect, 90);
    path.arcTo(topRightRect, 90, -90);

    // line to right bottom
    path.lineTo(bottomRightRect.topRight().x(), bottomRightRect.topRight().y() + tempBRRadius);
    // right arc
    // path.arcMoveTo(bottomRightRect, 0);
    path.arcTo(bottomRightRect, 0, -90);

    // line to left bottom
    path.lineTo(bottomLeftRect.bottomRight().x() - tempBLRadius, bottomLeftRect.bottomRight().y());
    // left bottom arc
    path.arcTo(bottomLeftRect, -90, -90);
    // line to top left close polygon
    path.lineTo(topLeftRect.bottomLeft().x(), topLeftRect.bottomLeft().y() - tempTLRadius);
    return path;
}

void AntRectangle::drawBorder(QPainter* painter, const QPainterPath& path)
{
    if (borderM.width() > 0.0)
    {
        painter->save();
        QPen pen;
        pen.setColor(borderM.color());
        pen.setStyle(borderM.style());
        pen.setWidthF(borderM.width());
        painter->setPen(pen);

        painter->drawPath(path);
        // painter->drawRoundedRect(boundingRect(), borderM.radius(), borderM.radius());

        painter->restore();
    }
}

void AntRectangle::drawBackground(QPainter* painter)
{
    painter->save();
    QPainterPath path{};
    if (!borderM.hasCustomRadius())
    {
        path = getBoundPath(borderM.radius(), borderM.radius(), borderM.radius(), borderM.radius());
    }
    else
    {
        path = getBoundPath(
            borderM.topLeftRadius(), borderM.topRightRadius(), borderM.bottomLeftRadius(), borderM.bottomRightRadius());
    }
    QBrush fillBrush{ colorM };

    painter->fillPath(path, colorM);

    drawBorder(painter, path);
    painter->restore();
}

void AntRectangle::paint(QPainter* painter)
{
    painter->save();
    painter->setRenderHint(QPainter::Antialiasing);

    drawBackground(painter);

    painter->restore();
}

}
