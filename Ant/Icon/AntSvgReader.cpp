#include "AntSvgReader.hpp"

#include <QFile>

AntSvgReader::AntSvgReader() : primaryColorM{ QColor("#333") }, secondaryColorM{ QColor{ "#D9D9D9" } } {}

void AntSvgReader::setPrimaryColor(const QColor& color)
{
    if (primaryColorM != color)
    {
        primaryColorM = color;
        emit dataChanged();
    }
}

QColor AntSvgReader::primaryColor() const
{
    return primaryColorM;
}

void AntSvgReader::setSecondaryColor(const QColor& color)
{
    if (secondaryColorM != color)
    {
        secondaryColorM = color;
        emit dataChanged();
    }
}

QColor AntSvgReader::secondaryColor() const
{
    return secondaryColorM;
}

bool AntSvgReader::load(const QString& filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        return false;
    }

    dataM = file.readAll();
    parseData();
    return true;
}

bool AntSvgReader::loadData(const QString& rawData)
{
    dataM = rawData;
    parseData();
    return true;
}

QByteArray AntSvgReader::data() const
{
    QString tempData(dataM);
    tempData.replace("primaryColor", primaryColorM.name());
    tempData.replace("primaryFillOpacity", QString::number(primaryColorM.alphaF(), 10, 2));
    auto tmpSecondaryColor = secondaryColorM.isValid() ? secondaryColorM : originSecondaryColorM;
    tempData.replace("secondaryColor", tmpSecondaryColor.name());
    tempData.replace("secondaryFillOpacity", QString::number(tmpSecondaryColor.alphaF(), 10, 2));

    return tempData.toLocal8Bit();
}

void AntSvgReader::parseData()
{
    const QString primaryColorStr("\"primaryColor\"");
    dataM.replace("\"#333\"", primaryColorStr);
    dataM.replace("path d", "path fill=\"primaryColor\" fill-opacity=\"primaryFillOpacity\" d");
    if (dataM.contains("\"#E6E6E6\"", Qt::CaseInsensitive))
    {
        dataM.replace("\"#E6E6E6\"", "\"secondaryColor\" fill-opacity=\"secondaryFillOpacity\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#E6E6E6");
    }
    if (dataM.contains("\"#D9D9D9\"", Qt::CaseInsensitive))
    {
        dataM.replace("\"#D9D9D9\"", "\"secondaryColor\" fill-opacity=\"secondaryFillOpacity\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#D9D9D9");
    }

    if (dataM.contains("\"#D8D8D8\"", Qt::CaseInsensitive))
    {
        dataM.replace("\"#D8D8D8\"", "\"secondaryColor\" fill-opacity=\"secondaryFillOpacity\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#D8D8D8");
    }
}
