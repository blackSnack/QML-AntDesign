#include "AntSpinPlugin.hpp"
#include <qqml.h>

void AntSpinPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntSpin/AntSpin.qml"), uri ,1, 0, "AntSpin");
}
