#include "AntBadgePlugin.hpp"
#include <qqml.h>

void AntBadgePlugin::registerTypes(const char *uri)
{
    qmlRegisterSingletonType(QUrl("qrc:/AntBadge/Style/AntBadgeStyle.qml"), uri, 1, 0, "AntBadgeStyle");
    qmlRegisterType(QUrl("qrc:/AntBadge/AntBadge.qml"), uri ,1, 0, "AntBadge");
}
