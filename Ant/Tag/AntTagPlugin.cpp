#include "AntTagPlugin.hpp"
#include <qqml.h>

void AntTagPlugin::registerTypes(const char* uri)
{
    qmlRegisterType(QUrl("qrc:/AntTag/AntTag.qml"), uri, 1, 0, "AntTag");
    qmlRegisterType(QUrl("qrc:/AntTag/Style/AntTagStyle.qml"), uri, 1, 0, "AntTagStyle");
    qmlRegisterSingletonType(QUrl("qrc:/AntTag/Style/PresetsColors.qml"), uri, 1, 0, "AntTagPresetsColors");
}
