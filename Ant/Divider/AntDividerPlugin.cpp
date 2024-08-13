#include "AntDividerPlugin.hpp"
#include <qqml.h>

void AntDividerPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntDivider/AntDivider.qml"), uri ,1, 0, "AntDivider");
    qmlRegisterType(QUrl("qrc:/Style/AntDivider/AntDividerStyle.qml"), uri ,1, 0, "AntDividerStyle");
}
