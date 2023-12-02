import QtQuick
import QtQuick.Window

import Ant 1.0
import Ant.Button 1.0
import Ant.Core 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        anchors.fill: parent
        color: "#EDEDED"
        Row {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Column {
                spacing: 20
                Repeater {
                    model: 3
                    AntButton {
                        required property int index
                        sizeType: index
                        type: 0
                        text: `Button_${index}`
                    }
                }
            }

            Column {
                spacing: 20
                Repeater {
                    model: 3
                    AntButton {
                        required property int index
                        sizeType: index
                        type: 1
                        text: `Button_${index}`
                    }
                }
            }

            Column {
                spacing: 20
                Repeater {
                    model: 3
                    AntButton {
                        required property int index
                        sizeType: index
                        type: 2
                        text: `Button_${index}`
                    }
                }
            }
        }
    }
}
