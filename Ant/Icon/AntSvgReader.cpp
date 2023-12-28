#include "AntSvgReader.hpp"

#include <QFile>

AntSvgReader::AntSvgReader(): primaryColorM {QColor("#333")}, secondaryColorM{QColor{"#D9D9D9"}} {}

void AntSvgReader::setPrimaryColor(const QColor &color)
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

void AntSvgReader::setSecondaryColor(const QColor &color)
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

bool AntSvgReader::load(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        return false;
    }

    dataM = file.readAll();
    parseData();
}

QByteArray AntSvgReader::data() const {
    QString tempData(dataM);
    tempData.replace("primaryColor", primaryColorM.name());
    tempData.replace("secondaryColor", secondaryColorM.isValid() ? secondaryColorM.name() : originSecondaryColorM.name());
    return tempData.toLocal8Bit();
}

void AntSvgReader::parseData()
{
    const QString primaryColorStr("\"primaryColor\"");
    dataM.replace("\"#333\"", primaryColorStr);
    dataM.replace("path d", "path fill=\"primaryColor\" d");
    if (dataM.contains("\"#E6E6E6\"", Qt::CaseInsensitive)) {
        dataM.replace("\"#E6E6E6\"", "\"secondaryColor\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#E6E6E6");
    }
    if (dataM.contains("\"#D9D9D9\"", Qt::CaseInsensitive)) {
        dataM.replace("\"#D9D9D9\"", "\"secondaryColor\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#D9D9D9");
    }

    if (dataM.contains("\"#D8D8D8\"", Qt::CaseInsensitive)) {
        dataM.replace("\"#D8D8D8\"", "\"secondaryColor\"", Qt::CaseInsensitive);
        originSecondaryColorM = QColor("#D8D8D8");
    }
}
