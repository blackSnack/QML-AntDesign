#include "AntAvatarPlugin.hpp"
#include <qqml.h>

void AntAvatarPlugin::registerTypes(const char* uri)
{
    qmlRegisterType(QUrl("qrc:/AntAvatar/AntAvatar.qml"), uri, 1, 0, "AntAvatar");
    qmlRegisterType(QUrl("qrc:/AntAvatar/AntAvatarGroup.qml"), uri, 1, 0, "AntAvatarGroup");
    qmlRegisterType(QUrl("qrc:/Style/AntAvatar/AntAvatarStyle.qml"), uri, 1, 0, "AntAvatarStyle");
}
