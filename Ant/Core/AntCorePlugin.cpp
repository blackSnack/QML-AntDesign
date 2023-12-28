#include "AntCorePlugin.hpp"
#include <QDir>
#include <QFontDatabase>
#include <qqml.h>
#include <QDebug>

#include "Rectangle/AntRectangle.hpp"
#include "Rectangle/BorderConfig.hpp"
#include "Awesome/AntAwesome.hpp"
#include "Awesome/AntAwesomeUtils.hpp"

void AntCorePlugin::registerTypes(const char *uri)
{
    QVector<QString> fontDirs{{":/AntCore/Font/FA_Font/"}, {":/AntCore/Font/FA_Font/"}};
    for (auto dirStr : fontDirs) {
        QDir fontDir(dirStr);
        auto fontfiles = fontDir.entryInfoList(QDir::Files);
        for (auto font : fontfiles)
        {
            auto id = QFontDatabase::addApplicationFont(font.filePath());
        }
    }
    // Awesome register singleton type
    Ant::AntAwesomeUtils::registerType(uri);
    // Registeer Awesome enum type
    qmlRegisterUncreatableMetaObject(Ant::staticMetaObject, uri, 1, 0, "AntFA", "");
    qmlRegisterType<Ant::AntRectangle>(uri, 1, 0, "AntRectangle");
    qmlRegisterType<Ant::BorderConfig>(uri, 1, 0, "AntBorder");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Theme/AntTheme.qml"), uri, 1, 0, "AntTheme");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Font/AntFont.qml"), uri ,1, 0, "AntFont");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Colors/AntColors.qml"), uri ,1, 0, "AntColors");
    qmlRegisterType(QUrl("qrc:/AntCore/Shadow/ShadowL1Down.qml"), uri ,1, 0, "ShadowL1Down");
}
