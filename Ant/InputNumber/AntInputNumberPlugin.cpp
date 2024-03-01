#include "AntInputNumberPlugin.hpp"
#include <qqml.h>

void AntInputNumberPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntInputNumber/AntInputNumber.qml"), uri ,1, 0, "AntInputNumber");
}
