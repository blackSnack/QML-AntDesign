import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import AntButton 1.0
import AntText 1.0
import AntPopover 1.0
import AntTooltip 1.0
import AntCore 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")


    Rectangle {
        anchors.fill: parent
        color: AntTheme.colorBgContainer
        Button {
            text: qsTr("Button")
            hoverEnabled: true

            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("This tool tip is shown after hovering the button for a second.")
        }

        Rectangle {
            id: bg
            x: 50
            y: 50
            width: 50
            height: 50
            radius: 5
            color: AntTheme.colorBgContainer
        }

        Column {
            spacing: 50
            anchors.left: parent.left
            anchors.leftMargin: 200
            AntButton {
                id: leftTop
                text: "left top popover"
            }

            AntButton {
                id: left
                text: "left popover"
            }

            AntButton {
                id: leftBottom
                text: "left bottom popover"
            }
        }

        AntPopover {
            target: left

            title: "left"
            placement: Ant.Left
            autoPlacement: false
            trigger: Ant.Click
            content: Column {
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
            }
        }

        AntPopover {
            target: leftTop

            title: "leftTop"
            placement: Ant.LeftTop
            content: Column {
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
            }
        }

        AntPopover {
            target: leftBottom

            placement: Ant.LeftBottom
            title: "leftBottom"

            content: Column {
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
                AntText {
                    text: "Content"
                }

                AntText {
                    text: "Content"
                }
            }
        }
    }
}
