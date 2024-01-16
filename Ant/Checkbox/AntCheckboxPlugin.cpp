#include "AntCheckboxPlugin.hpp"
#include <qqml.h>

void AntCheckboxPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntCheckbox/AntCheckbox.qml"), uri ,1, 0, "AntCheckbox");
}
