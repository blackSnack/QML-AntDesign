
#include "AntRectangle.hpp"
#include <QDir>
#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<AntRectangle>("Ant", 1, 0, "AntRectangle");
    qmlRegisterType<BorderConfig>("Ant", 1, 0, "Border");
    QQuickStyle::setStyle("Ant");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/AntDesignn/Main.qml"_qs);
    engine.addImportPath("qrc:/");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
