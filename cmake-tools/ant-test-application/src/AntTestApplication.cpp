#include "ant/AntTestApplication.hpp"
#include <QDebug>

namespace Ant {
AntTestApplication::AntTestApplication(int& argc, char **argv)
    : enabledHighDpiM{ []() {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
          QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
          qDebug() << "Enabled high DPI scaling";
#endif
          return true;
      }() },
      guiAppM{ argc, argv }
{
    engineM.addImportPath("plugins");
    engineM.addImportPath("../plugins");
}

AntTestApplication::~AntTestApplication() {}

void AntTestApplication::load(const QUrl& url)
{
    QObject::connect(
        &engineM,
        &QQmlApplicationEngine::exit,
        &guiAppM,
        [](int code) { QCoreApplication::exit(code); },
        Qt::QueuedConnection);
    engineM.load(url);
}

int AntTestApplication::exec()
{
    return guiAppM.exec();
}

} // namespace Ant
