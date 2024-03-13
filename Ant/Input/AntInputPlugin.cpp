#include "AntInputPlugin.hpp"
#include <qqml.h>

void AntInputPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntInput/AntInput.qml"), uri ,1, 0, "AntInput");
    qmlRegisterType(QUrl("qrc:/AntInput/Style/AntInputStyle.qml"), uri ,1, 0, "AntInputStyle");
}
