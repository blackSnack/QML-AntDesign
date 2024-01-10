import QtQuick 2.15

import AntBadge 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Row {
        x: 100
        y: 50
        id: top
        spacing: 20
        AntBadge {
            status: AntBadgeStyle.Status.Success
        }

        AntBadge {
            status: AntBadgeStyle.Status.Error
        }

        AntBadge {
            status: AntBadgeStyle.Status.Default
        }

        AntBadge {
            status: AntBadgeStyle.Status.Processing
        }

        AntBadge {
            status: AntBadgeStyle.Status.Warning
        }
    }

    Column {
        id: layout2
        anchors.left: top.left
        anchors.top: top.bottom
        anchors.topMargin: 20
        spacing: 20
        AntBadge {
            status: AntBadgeStyle.Status.Success
            text: "Success"
        }

        AntBadge {
            status: AntBadgeStyle.Status.Error
            text: "Error"
        }

        AntBadge {
            status: AntBadgeStyle.Status.Default
            text: "Default"
        }

        AntBadge {
            status: AntBadgeStyle.Status.Processing
            text: "Processing"
        }

        AntBadge {
            status: AntBadgeStyle.Status.Warning
            text: "Warning"
        }
    }

    Column {
        spacing: 10
        AntBadge {
            count: 9
        }

        AntBadge {
            count: 10000
        }

        AntBadge {
            overflowCount: 9999
            count: 10000
        }

        AntBadge {
            size: "small"
            count: 9
        }

        AntBadge {
            size: "small"
            count: 50
        }

        AntBadge {
            size: "small"
            count: 999
        }
    }

   Row {
        anchors.top: layout2.bottom
        anchors.topMargin: 20
        anchors.left: layout2.left
        spacing: 20
        Rectangle {
            id: rect
            width: 50
            height: 50
            color: "gray"
            radius: 8
        }

        AntBadge {
            target: rect
            size: "small"
            count: 999
        }

        Rectangle {
            id: dotRect
            width: 50
            height: 50
            color: "gray"
            radius: 8
        }

        AntBadge {
            target: dotRect
            size: "small"
            dot: true
            count: 999
        }

        Rectangle {
            id: offsetRect
            width: 50
            height: 50
            color: "gray"
            radius: 8
        }

        AntBadge {
            target: offsetRect
            size: "small"
            offset: Qt.point(10, 10)
            count: 999
        }
   }
}
