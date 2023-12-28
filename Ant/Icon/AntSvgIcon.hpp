#pragma once
#include <QObject>
#include <QImage>
#include <QQuickPaintedItem>
#include <QSvgRenderer>
#include "AntSvgReader.hpp"
#include "../QmlHelper/QmlUtil.hpp"
namespace Ant
{
class AntSvgIcon : public QQuickPaintedItem
{
    Q_OBJECT

    CREATE_QML_PROPERTY(QString, source, Source)
    Q_PROPERTY(QColor primaryColor READ primaryColor WRITE setPrimaryColor)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor WRITE setSecondaryColor)

    enum Type {
        Filled,
        Outlined,
        Twotone
    };
public:
    explicit AntSvgIcon(QQuickItem* parent = nullptr);

    // QQuickPaintedItem interface
public:
    QColor primaryColor() const;
    void setPrimaryColor(const QColor& color);
    QColor secondaryColor() const;
    void setSecondaryColor(const QColor& color);
    void paint(QPainter *painter);

private:
    AntSvgReader svgReaderM;
    QSvgRenderer svgRenderM;
};
}
