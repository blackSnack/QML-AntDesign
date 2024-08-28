#include "AntSelectPlugin.hpp"
#include <qqml.h>

void AntSelectPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntSelect/AntSelect.qml"), uri ,1, 0, "AntSelect");
    qmlRegisterType(QUrl("qrc:/Style/AntSelect/AntSelectStyle.qml"), uri ,1, 0, "AntSelectStyle");
}
