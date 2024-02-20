import QtQuick 2.15

import AntSlider 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    FocusScope {
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent

            onClicked: {
                parent.forceActiveFocus()
            }
        }
    }

    AntSlider {
        width: 100
        height: 20
    }

    AntSlider {
        x: 10
        y: 40
        width: 100
        height: 20
    }

    AntSlider {
        x: 10
        y: 60
        disabled: true
        width: 100
        height: 20
        value: 50
    }

    Column {
        y: 100
        AntSlider {
            // disabled: true
            width: 100
            value: 30
        }
        AntSlider {
            // disabled: true
            width: 100
            value: 50
        }
        AntSlider {
            // disabled: true
            width: 100
            value: 80
        }
    }

    Row {
        x: 300
        y: 100

        AntSlider {
            vertical: true
            height: 100
            value: 30
        }
        AntSlider {
            vertical: true
            height: 100
            value: 50
        }
        AntSlider {
            vertical: true
            height: 100
            value: 80
        }
    }
}
