#include "AntSvgIcon.hpp"
#include <QPainter>
#include <QRegularExpression>
namespace Ant
{
AntSvgIcon::AntSvgIcon(QQuickItem* parent): QQuickPaintedItem(parent)
{
    svgRenderM.setAspectRatioMode(Qt::AspectRatioMode::IgnoreAspectRatio);
    connect(this, & AntSvgIcon::sourceChanged, [this](){
        QString name {sourceM};
        QString resultFileName {":/AntIcon/Icons/svg/"};
        Type type;
        if(sourceM.endsWith("TwoTone")) {
            type = Type::Twotone;
            name.remove("TwoTone");
            resultFileName.append("twotone/");
        }else if (sourceM.endsWith("Outlined")) {
            type = Type::Outlined;
            name.remove("Outlined");
            resultFileName.append("outlined/");
        }else {
            type = Type::Filled;
            name.remove("Filled");
            resultFileName.append("filled/");
        }

        auto strList = name.split(QRegularExpression("(?=[A-Z])"), Qt::SkipEmptyParts);
        resultFileName.append(strList.join("-").toLower()).append(".svg");

        svgReaderM.load(resultFileName);
        svgRenderM.load(svgReaderM.data());
        svgRenderM.setViewBox(boundingRect());

    });
    connect(&svgRenderM, &QSvgRenderer::repaintNeeded, this, &QQuickItem::update);
    connect(&svgReaderM, &AntSvgReader::dataChanged, [this](){
        svgRenderM.load(svgReaderM.data());
        emit svgRenderM.repaintNeeded();
    });
}

QColor AntSvgIcon::primaryColor() const
{
    return svgReaderM.primaryColor();
}

void AntSvgIcon::setPrimaryColor(const QColor &color)
{
    svgReaderM.setPrimaryColor(color);
}

QColor AntSvgIcon::secondaryColor() const
{
    return svgReaderM.secondaryColor();
}

void AntSvgIcon::setSecondaryColor(const QColor &color)
{
    svgReaderM.setSecondaryColor(color);
}

void AntSvgIcon::paint(QPainter *painter)
{
    painter->save();
    painter->setRenderHint(QPainter::Antialiasing);

    svgRenderM.render(painter, boundingRect());
    painter->restore();
}
}
