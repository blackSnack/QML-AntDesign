#include "AntColorPickerPlugin.hpp"
#include <qqml.h>

void AntColorPickerPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntColorPicker/AntColorPicker.qml"), uri ,1, 0, "AntColorPicker");
}
