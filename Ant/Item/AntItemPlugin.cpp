#include "AntItemPlugin.hpp"
#include <qqml.h>

void AntItemPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntItem/AntItem.qml"), uri ,1, 0, "AntItem");
}
