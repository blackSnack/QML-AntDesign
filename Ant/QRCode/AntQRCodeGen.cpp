#include "AntQRCodeGen.hpp"

#include "qrcodegen/qrcodegen.hpp"
#include <QDebug>
#include <string>
#include <sstream>
#include <vector>
#include <QThreadPool>

using qrcodegen::QrCode;
using qrcodegen::QrSegment;
using std::uint8_t;

namespace Detail {

bool isDirty(const QString& l, const QString& r)
{
    return l != r;
}
}
namespace Ant {


void QRCodeGen::generateSvg(const QByteArray& data, int ecc, int border, int minLevel, int maxLevel, int mask, bool boostEcl)
{
    auto func = [this, data, ecc, border, minLevel, maxLevel, mask, boostEcl](){
        try
        {
            std::vector<qrcodegen::QrSegment> segs = qrcodegen::QrSegment::makeSegments(data.constData());

            const qrcodegen::QrCode qr =
                qrcodegen::QrCode::encodeSegments(segs, static_cast<QrCode::Ecc>(ecc), minLevel, maxLevel, mask, boostEcl);
            const int size = qr.getSize();
            if (border < 0)
                throw std::domain_error("Border must be non-negative");
            if (border > INT_MAX / 2 || border * 2 > INT_MAX - qr.getSize())
                throw std::overflow_error("Border too large");

            std::ostringstream sb;
            sb << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
            sb << "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" "
                  "\"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n";
            sb << "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" viewBox=\"0 0 ";
            sb << (qr.getSize() + border * 2) << " " << (qr.getSize() + border * 2) << "\" stroke=\"none\">\n";
            sb << "\t<rect width=\"100%\" height=\"100%\" fill=\"#E6E6E6\"/>\n";
            sb << "\t<path d=\"";
            for (int y = 0; y < qr.getSize(); y++)
            {
                for (int x = 0; x < qr.getSize(); x++)
                {
                    if (qr.getModule(x, y))
                    {
                        if (x != 0 || y != 0)
                            sb << " ";
                        sb << "M" << (x + border) << "," << (y + border) << "h1v1h-1z";
                    }
                }
            }
            sb << "\"/>\n";
            sb << "</svg>\n";
            emit generateFinished(data, QString::fromStdString(sb.str()));
            return;
        }
        catch (std::domain_error e)
        {
            qDebug()  << e.what();
        }
        catch (std::overflow_error e)
        {
            qDebug() << e.what();
        }
        emit generateFinished(data, "");
    };

    QThreadPool::globalInstance()->start(func);
}

void AntQRCodeGen::updateQRCode()
{
    setLoading(true);
    if (qrCodeGenPtrM) {
        qrCodeGenPtrM->generateSvg(data().toLocal8Bit(), ecc(), border(), minLevel(), maxLevel(), mask(), boostEcl());
    }
}

AntQRCodeGen::AntQRCodeGen(QObject* parent) : QObject(parent), qrCodeGenPtrM{new QRCodeGen {}}
{
    connect(this, &AntQRCodeGen::dataChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::eccChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::borderChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::minLevelChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::maxLevelChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::maskChanged, this, &AntQRCodeGen::updateQRCode);
    connect(this, &AntQRCodeGen::boostEclChanged, this, &AntQRCodeGen::updateQRCode);

    connect(qrCodeGenPtrM.get(), &QRCodeGen::generateFinished, [this](const QString& originData, const QString& svgData) {
        if(Detail::isDirty(originData, data())) {
            return;
        }
        setQRCode(svgData);
        setLoading(false);
    });
}

} // namespace Ant
