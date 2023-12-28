import QtQuick 2.15

import AntTooltip 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        width: 1000
        height:100
        color: "pink"
    }

    AntTooltip {
        x: 50
        y: 50
        title: "Hello ToolTip"
    }


    Rectangle {
        width: 100
        height:1000
        color: "pink"
    }
}
