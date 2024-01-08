import QtQuick 2.15
import QtQuick.Controls 2.15

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
        placement: AntTooltip.Placement.Top
    }

    AntTooltip {
        target: topLeft
        title: "Top Left"
        placement: AntTooltip.Placement.TopLeft
    }

    AntTooltip {
        target: topRight
        title: "Top Right"
        placement: AntTooltip.Placement.TopRight
    }

    AntTooltip {
        target: bottom
        title: "Bottom Tooltip"
        placement: AntTooltip.Placement.Bottom
    }

    AntTooltip {
        target: bottomLeft
        title: "Bottom left"
        placement: AntTooltip.Placement.BottomLeft
    }

    AntTooltip {
        target: bottomRight
        title: "Bottom Right"
        placement: AntTooltip.Placement.BottomRight
    }

    AntTooltip {
        target: left
        title: "Left Tooltip"
        placement: AntTooltip.Placement.Left
    }

    AntTooltip {
        target: leftTop
        height: 80
        title: "Left Top"
        placement: AntTooltip.Placement.LeftTop
    }

    AntTooltip {
        target: leftBottom
        height: 80
        title: "Left bottom"
        trigger: AntTooltip.Trigger.Click
        placement: AntTooltip.Placement.LeftBottom
    }

    AntTooltip {
        target: right
        title: "Right Tooltip"
        placement: AntTooltip.Placement.Right
    }

    AntTooltip {
        target: rightTop
        height: 80
        title: "Right Top"
        placement: AntTooltip.Placement.RightTop
    }

    AntTooltip {
        id: rbt
        target: rightBottom
        height: 80
        title: "Right bottom"
        placement: AntTooltip.Placement.RightBottom
        trigger: AntTooltip.Trigger.Click
    }

}
