#include "AntPaginationPlugin.hpp"
#include <qqml.h>

void AntPaginationPlugin::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/AntPagination/AntPagination.qml"), uri ,1, 0, "AntPagination");
    qmlRegisterType(QUrl("qrc:/Style/AntPagination/AntPaginationStyle.qml"), uri ,1, 0, "AntPaginationStyle");
}
