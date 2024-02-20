import QtQuick 2.15


import AntCore 1.0

MouseArea {
    id: root

    property bool hovered: containsMouse
    property Component content: Rectangle {
        anchors.fill: parent
    }

    hoverEnabled: true

    Loader {
        anchors.fill: parent
        sourceComponent: content
    }

    onPressed: mouse => mouse.accepted = false
}
