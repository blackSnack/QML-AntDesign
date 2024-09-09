#include "AntMenuPlugin.hpp"
#include <qqml.h>

void AntMenuPlugin::registerTypes(const char* uri)
{
    qmlRegisterType(QUrl("qrc:/AntMenu/AntMenu.qml"), uri, 1, 0, "AntMenu");
    qmlRegisterType(QUrl("qrc:/AntMenu/Style/AntMenuStyle.qml"), uri, 1, 0, "AntMenuStyle");
}
