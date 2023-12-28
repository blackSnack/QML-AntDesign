#include "AntButtonPlugin.hpp"
#include <qqml.h>

void AntButtonPlugin::registerTypes(const char *uri)
{
    qmlRegisterSingletonType(QUrl("qrc:/AntButton/Style/AntButtonStyle.qml"), uri, 1, 0, "AntButtonStyle");
    qmlRegisterSingletonType(QUrl("qrc:/AntButton/Style/AntButtonStyleToken.qml"), uri, 1, 0, "AntButtonStyleToken");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/DefaultStyle.qml"), uri, 1, 0, "DefaultStyle");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/PrimaryStyle.qml"), uri, 1, 0, "PrimaryStyle");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/DashedStyle.qml"), uri, 1, 0, "DashedStyle");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/LinkStyle.qml"), uri, 1, 0, "LinkStyle");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/TextStyle.qml"), uri, 1, 0, "TextStyle");
    qmlRegisterType(QUrl("qrc:/AntButton/Style/ButtonSizeStyle.qml"), uri, 1, 0, "ButtonSizeStyle");

    qmlRegisterType(QUrl("qrc:/AntButton/AntButton.qml"), uri ,1, 0, "AntButton");
}
