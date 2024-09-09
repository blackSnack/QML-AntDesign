#include "AntCorePlugin.hpp"
#include <QDebug>
#include <QDir>
#include <QFontDatabase>
#include <QQmlFileSelector>
#include <qqml.h>

#include "Ant.hpp"
#include "Awesome/AntAwesomeUtils.hpp"
#include "LazyItemProxy/LazyItemProxy.hpp"
#include "Rectangle/AntRectangle.hpp"
#include "Rectangle/BorderConfig.hpp"
#include <QDebug>

void AntCorePlugin::registerTypes(const char* uri)
{
    QVector<QString> fontDirs{ { ":/AntCore/Font/FA_Font/" }, { ":/AntCore/Font/SF_Font/" } };
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
    qmlRegisterUncreatableMetaObject(Ant::staticMetaObject, uri, 1, 0, "Ant", "");
    regiseterAntEnums(uri);
    qmlRegisterType<Ant::AntRectangle>(uri, 1, 0, "AntRectangle");
    qmlRegisterType<Ant::BorderConfig>(uri, 1, 0, "AntBorder");
    qmlRegisterType<Ant::LazyItemProxy>(uri, 1, 0, "LazyItemProxy");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Theme/AntTheme.qml"), uri, 1, 0, "AntTheme");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Font/AntFont.qml"), uri, 1, 0, "AntFont");
    qmlRegisterSingletonType(QUrl("qrc:/AntCore/Colors/AntColors.qml"), uri, 1, 0, "AntColors");
    qmlRegisterType(QUrl("qrc:/AntCore/Shadow/ShadowL1Down.qml"), uri, 1, 0, "ShadowL1Down");
    qmlRegisterType(QUrl("qrc:/AntCore/Background/AntTransparentBg.qml"), uri, 1, 0, "AntTransparentBg");
    // How to register js to qml plugin
    // qmlRegisterType(QUrl("qrc:/AntCore/Utils/Utils.js"), uri, 1, 0, "AntCoreUtils");
}

void AntCorePlugin::initializeEngine(QQmlEngine* engine, const char* uri)
{
    Q_UNUSED(uri)
    Q_UNUSED(engine)
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QQmlFileSelector* selector = QQmlFileSelector::get(engine);
    selector->setExtraSelectors({ "qt5" });
#endif
}
