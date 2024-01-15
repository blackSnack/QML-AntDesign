#include "AntMaskPlugin.hpp"
#include <qqml.h>

void AntMaskPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntMask/AntMask.qml"), uri ,1, 0, "AntMask");
}
