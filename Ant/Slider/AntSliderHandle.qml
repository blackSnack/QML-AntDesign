import QtQuick 2.15


import AntCore 1.0
FocusScope {
    id: root

    property var antStyle: []
    property alias hoverEnabled: mouseArea.hoverEnabled
    property bool hovered: activeFocus || mouseArea.containsMouse
    property bool selected: false
    property Component content: Rectangle {
        anchors.fill: parent
    }
    focus: true

    implicitWidth: hovered ? antStyle.handleSizeHover + antStyle.handleLineWidthHover * 2 : antStyle.handleSize + antStyle.handleLineWidth * 2
    implicitHeight: width

    Loader {
        id: loader
        anchors.fill: parent
        sourceComponent: content
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed: mouse => {mouse.accepted = false}
    }
}
