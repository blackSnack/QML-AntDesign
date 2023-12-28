#include "AntIconPlugin.hpp"
#include "AntSvgIcon.hpp"
#include <qqml.h>
namespace Ant
{
void AntIconPlugin::registerTypes(const char *uri)
{
    qmlRegisterType<Ant::AntSvgIcon>("AntIcon", 1, 0, "AntSvgIcon");
    qmlRegisterType<Ant::AntSvgIcon>("AntIconPrivate", 1, 0, "AntSvgIcon");
    qmlRegisterType(QUrl("qrc:/AntIcon/AntIcon.qml"), uri ,1, 0, "AntIcon");
}
}
