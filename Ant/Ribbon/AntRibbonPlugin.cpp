#include "AntRibbonPlugin.hpp"
#include <qqml.h>

void AntRibbonPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntRibbon/AntRibbon.qml"), uri ,1, 0, "AntRibbon");
}
