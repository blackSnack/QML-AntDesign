#include "AntSpacePlugin.hpp"
#include <qqml.h>

void AntSpacePlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntSpace/AntSpace.qml"), uri ,1, 0, "AntSpace");
    qmlRegisterType(QUrl("qrc:/Style/AntSpace/AntSpaceStyle.qml"), uri ,1, 0, "AntSpaceStyle");
}
