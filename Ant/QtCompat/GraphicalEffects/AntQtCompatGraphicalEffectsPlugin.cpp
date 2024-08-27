#include "AntQtCompatGraphicalEffectsPlugin.hpp"
#include <qqml.h>

void AntQtCompatGraphicalEffectsPlugin::registerTypes(const char* uri)
{
    qmlRegisterType(QUrl("qrc:/AntQtCompatGraphicalEffects/CompatDropShadow.qml"), uri, 1, 0, "CompatDropShadow");
    qmlRegisterType(QUrl("qrc:/AntQtCompatGraphicalEffects/CompatLinearGradient.qml"), uri, 1, 0, "CompatLinearGradient");
    qmlRegisterType(QUrl("qrc:/AntQtCompatGraphicalEffects/CompatOpacityMask.qml"), uri, 1, 0, "CompatOpacityMask");
}
