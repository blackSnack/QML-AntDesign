#include "AntTextPlugin.hpp"
#include <qqml.h>

void AntTextPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntText/AntText.qml"), uri ,1, 0, "AntText");
}
