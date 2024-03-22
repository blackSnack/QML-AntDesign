#include "Ant@Template@Plugin.hpp"
#include <qqml.h>

void Ant@Template@Plugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/Ant@Template@/Ant@Template@.qml"), uri ,1, 0, "Ant@Template@");
    qmlRegisterType(QUrl("qrc:/Style/Ant@Template@/Ant@Template@Style.qml"), uri ,1, 0, "Ant@Template@Style");
}
