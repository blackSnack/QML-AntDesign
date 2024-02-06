#include "AntPopoverPlugin.hpp"
#include <qqml.h>

void AntPopoverPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntPopover/AntPopover.qml"), uri ,1, 0, "AntPopover");
}
