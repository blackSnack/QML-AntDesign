#pragma once
#include <QObject>
#include <QQmlEngine>

#include "Enums/AntAwesome.hpp"
#include "Enums/AntEnums.hpp"

static void regiseterAntEnums(const char * uri)
{
    qmlRegisterUncreatableMetaObject(Ant::staticMetaObject, uri, 1, 0, "Ant", "");
    qmlRegisterUncreatableMetaObject(Ant::FA::staticMetaObject, uri, 1, 0, "AntFA", "");
}
