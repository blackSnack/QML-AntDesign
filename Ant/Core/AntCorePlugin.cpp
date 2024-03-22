#include "AntCorePlugin.hpp"
#include <QDebug>
#include <QDir>
#include <QFontDatabase>
#include <qqml.h>

#include "Ant.hpp"
#include "Awesome/AntAwesomeUtils.hpp"
#include "Rectangle/AntRectangle.hpp"
#include "Rectangle/BorderConfig.hpp"

void AntCorePlugin::registerTypes(const char* uri)
{
    QVector<QString> fontDirs{ { ":/AntCore/Font/FA_Font/" }, { ":/AntCore/Font/FA_Font/" } };
    for (auto dirStr : fontDirs)
    {
        QDir fontDir(dirStr);
        auto fontfiles = fontDir.entryInfoList(QDir::Files);
        for (auto font : fontfiles)
        {
            auto id = QFontDatabase::addApplicationFont(font.filePath());
        }
    }
    // Awesome register singleton type
    Ant::AntAwesomeUtils::registerType(uri);
    // Registeer Ant enum type
    // qmlRegisterUncreatableMetaObject(Ant::staticMetaObject, uri, 1, 0, "Ant", "");
    regiseterAntEnums(uri);
    qmlRegisterType<Ant::AntRectangle>(uri, 1, 0, "AntRectangle");
    qmlRegisterType<Ant::BorderConfig>(uri, 1, 0, "AntBorder");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Theme/AntTheme.qml"), uri, 1, 0, "AntTheme");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Font/AntFont.qml"), uri, 1, 0, "AntFont");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Colors/AntColors.qml"), uri, 1, 0, "AntColors");
    qmlRegisterType(QUrl("qrc:/AntCore/Shadow/ShadowL1Down.qml"), uri, 1, 0, "ShadowL1Down");
    qmlRegisterType(QUrl("qrc:/AntCore/Background/AntTransparentBg.qml"), uri, 1, 0, "AntTransparentBg");
    // How to register js to qml plugin
    // qmlRegisterType(QUrl("qrc:/AntCore/Utils/Utils.js"), uri, 1, 0, "AntCoreUtils");
}
