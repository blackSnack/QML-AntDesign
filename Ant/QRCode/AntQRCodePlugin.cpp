#include "AntQRCodePlugin.hpp"
#include "AntQRCodeGen.hpp"
#include <qqml.h>

void AntQRCodePlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntQRCode/AntQRCode.qml"), uri ,1, 0, "AntQRCode");
    qmlRegisterType<Ant::AntQRCodeGen>(uri, 1, 0, "AntQRCodeGen");

    // qmlRegisterSingletonType<Ant::AntQRCodeGen>(uri, 1, 0, "AntQRCodeGen", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
    //     Q_UNUSED(engine)
    //     Q_UNUSED(scriptEngine)

    //     Ant::AntQRCodeGen *qrcodegen = new Ant::AntQRCodeGen();
    //     return qrcodegen;
    // });
}
