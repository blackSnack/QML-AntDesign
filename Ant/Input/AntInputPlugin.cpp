#include "AntInputPlugin.hpp"
#include <qqml.h>

void AntInputPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntInput/AntInput.qml"), uri ,1, 0, "AntInput");
}
