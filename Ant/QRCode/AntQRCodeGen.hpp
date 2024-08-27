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
#include <QByteArray>
#include <QImage>
#include <QObject>
#include <QSharedPointer>
#include <QThread>
#include "../QmlHelper/QmlUtil.hpp"
namespace Ant {
class QRCodeGen;
class AntQRCodeGen: public QObject
{
    Q_OBJECT
    CREATE_QML_PROPERTY(bool, loading, Loading)
    CREATE_QML_PROPERTY(bool, error, Error)
    CREATE_QML_PROPERTY(QString, data, Data)
    CREATE_QML_PROPERTY(QString, qrCode, QRCode)
    CREATE_QML_PROPERTY(int, ecc, Ecc, 0)
    CREATE_QML_PROPERTY(int, border, Border, 0)
    CREATE_QML_PROPERTY(int, minLevel, MinLevel, 1)
    CREATE_QML_PROPERTY(int, maxLevel, MaxLevel, 40)
    CREATE_QML_PROPERTY(int, mask, Mask, -1)
    CREATE_QML_PROPERTY(bool, boostEcl, BoostEcl, true)
public:
    enum Ecc
    {
        EccLow = 0,  // The QR Code can tolerate about  7% erroneous codewords
        EccMedium,   // The QR Code can tolerate about 15% erroneous codewords
        EccQuartile, // The QR Code can tolerate about 25% erroneous codewords
        EccHigh,     // The QR Code can tolerate about 30% erroneous codewords
    };
    Q_ENUMS(Ecc);

public:
    AntQRCodeGen(QObject* parent = nullptr);
    ~AntQRCodeGen() = default;

private:
    void updateQRCode();

    QSharedPointer<QRCodeGen> qrCodeGenPtrM{nullptr};
};

class QRCodeGen: public QObject
{
    Q_OBJECT
public:
    QRCodeGen(QObject * parent = nullptr): QObject{parent} {}
    ~QRCodeGen() = default;
public slots:
    void generateSvg(
        const QByteArray& data, int ecc, int border = 0, int minLevel = 1, int maxLevel = 40, int mask = -1, bool boostEcl = true);
signals:
    void generateFinished(const QString& originData, const QString& svgData);

private:
    QSharedPointer<QThread> threadPtrM {nullptr};
};

} // namespace Ant
