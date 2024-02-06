#pragma once
#include <QObject>
#include <QQmlEngine>

#include "Enums/AntAwesome.hpp"

namespace Ant {
class AntAwesomeUtils: public QObject
{
    Q_OBJECT
public:
    AntAwesomeUtils(QObject* parent = nullptr);

    static void registerType(const char * uri) {
        qmlRegisterSingletonType<Ant::AntAwesomeUtils>(uri, 1, 0, "AntFAUtils", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
            Q_UNUSED(engine)
            Q_UNUSED(scriptEngine)

            AntAwesomeUtils *antFAUtils = new AntAwesomeUtils();
            return antFAUtils;
        });
    }

    Q_INVOKABLE QVariantMap getFAObject(FA::FontAwesomeType id);

    Q_INVOKABLE QChar getFAUnicode(FA::FontAwesomeType id);
};
}



