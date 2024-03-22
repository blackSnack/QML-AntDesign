#include "AntSliderPlugin.hpp"
#include <qqml.h>

void AntSliderPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntSlider/AntSlider.qml"), uri ,1, 0, "AntSlider");
    qmlRegisterType(QUrl("qrc:/AntSlider/AntSliderRail.qml"), uri ,1, 0, "AntSliderRail");
    qmlRegisterType(QUrl("qrc:/AntSlider/AntSliderHandle.qml"), uri ,1, 0, "AntSliderHandle");
}
