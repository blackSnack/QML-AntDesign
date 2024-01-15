#pragma once
#include <QColor>
#include <QString>
#include <QObject>

class AntSvgReader: public QObject
{
    Q_OBJECT
public:
    AntSvgReader();

    void setPrimaryColor(const QColor& color);
    QColor primaryColor() const;

    void setSecondaryColor(const QColor& color);
    QColor secondaryColor() const;

    bool load(const QString& filePath);
    bool loadData(const QString& rawData);

    QByteArray data() const;
signals:
    void dataChanged();

private:
    void parseData();
    QColor primaryColorM;
    QColor secondaryColorM;
    // QColor originPrimaryColorM;
    QColor originSecondaryColorM;
    QString dataM;
};
