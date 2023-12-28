#include "AntTooltipPlugin.hpp"
#include <qqml.h>

void AntTooltipPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntTooltip/AntTooltip.qml"), uri ,1, 0, "AntTooltip");
}
