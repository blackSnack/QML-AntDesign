#include "AntTagPlugin.hpp"
#include <qqml.h>

void AntTagPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntTag/AntTag.qml"), uri ,1, 0, "AntTag");
    qmlRegisterType(QUrl("qrc:/Style/AntTag/AntTagStyle.qml"), uri ,1, 0, "AntTagStyle");
}
