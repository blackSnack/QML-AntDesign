import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import AntSpin 1.0
import AntCore 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        anchors.fill: parent
        color: AntTheme.colorBgContainer
    Rectangle {
        width: 400
        height: 300
        anchors.centerIn: parent
        color: AntTheme.colorBgContainer
        Rectangle {
            x: -50
            y: -50
            width: 200
            height: 100
            radius: 6

            color: AntTheme.colorBgContainer


            AntSpin {
                spinning: true
            }
        }


        AntSpin {
            spinning: true
            size: "large"
            tip: "Loading"
        }

        AntSpin {
            id: fullscreenSpin
            size: "large"
            fullscreen: true
            tip: "Fullscreen"
        }
    }
    }

    Button {
        width: 100
        height: 50

        text: "Show Fullscreen"

        onClicked: {
            fullscreenSpin.spinning = true
        }
    }
}
