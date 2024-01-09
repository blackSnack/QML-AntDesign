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
}
