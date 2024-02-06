#include "AntDropdownPlugin.hpp"
#include <qqml.h>

void AntDropdownPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntDropdown/AntDropdown.qml"), uri ,1, 0, "AntDropdown");
}
