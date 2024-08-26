#include "ant/AntTestApplication.hpp"

int main(int argc, char* argv[])
{
    Ant::AntTestApplication app(argc, argv);
    app.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
