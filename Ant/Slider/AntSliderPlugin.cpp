#include "AntSliderPlugin.hpp"
#include <qqml.h>

void AntSliderPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntSlider/AntSlider.qml"), uri ,1, 0, "AntSlider");
}
