import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntButton 1.0
import AntTooltip 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // Rectangle {
    //     width: 1000
    //     height:100
    //     color: "pink"
    // }

    AntTooltip {
        target: t

        title: "Top"
        placement: Ant.Top
    }

    AntButton {
        id: t
        y: 100
        text: "TL"
    }

    Row {

        Rectangle {
            width: 100
            height: 100

            color: "red"
        }

    }


    Item {

        width: 300
        height: 200
        anchors.centerIn: parent
        Row {
            id: topRow
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            AntButton {
                id: topLeft

                text: "TL"
            }

            AntButton {
                id: top

                text: "Top"
            }

            AntButton {
                id: topRight

                text: "TR"
            }
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            AntButton {
                id: bottomLeft

                text: "BL"
            }

            AntButton {
                id: bottom

                text: "Bottom"
            }

            AntButton {
                id: bottomRight

                text: "BR"
            }
        }

        Column {
            anchors.right: topRow.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            AntButton {
                id: leftTop

                text: "LT"
            }

            AntButton {
                id: left

                text: "Left"
            }

            AntButton {
                id: leftBottom

                text: "LB"
            }
        }

        Column {
            anchors.left: topRow.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            AntButton {
                id: rightTop

                text: "RT"
            }

            AntButton {
                id: right

                text: "Right"
            }

            AntButton {
                id: rightBottom

                text: "RB"
            }
        }
    }

    AntTooltip {
        target: top
        height: 100
        title: "Top"
        placement: Ant.Top
    }

    AntTooltip {
        target: topLeft
        title: "Top Left"
        placement: Ant.TopLeft
    }

    AntTooltip {
        target: topRight
        title: "Top Right"
        placement: Ant.TopRight
    }

    AntTooltip {
        target: bottom
        title: "Bottom Tooltip"
        placement: Ant.Bottom
    }

    AntTooltip {
        target: bottomLeft
        title: "Bottom left"
        placement: Ant.BottomLeft
    }

    AntTooltip {
        target: bottomRight
        title: "Bottom Right"
        placement: Ant.BottomRight
    }

    AntTooltip {
        target: left
        title: "Left Tooltip"
        placement: Ant.Left
    }

    AntTooltip {
        target: leftTop
        height: 80
        title: "Left Top"
        placement: Ant.LeftTop
    }

    AntTooltip {
        target: leftBottom
        height: 80
        title: "Left bottom"
        trigger: Ant.Click
        placement: Ant.LeftBottom
    }

    AntTooltip {
        target: right
        title: "Right Tooltip"
        placement: Ant.Right
        arrow: false
    }

    AntTooltip {
        target: rightTop
        height: 0
        title: "Right Top"
        placement: Ant.RightTop
    }

    AntTooltip {
        id: rbt
        target: rightBottom
        height: 80
        title: "Right bottom"
        placement: Ant.RightBottom
        trigger: Ant.Click
        arrow: false
    }
}
