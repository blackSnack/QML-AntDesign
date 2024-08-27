import QtQuick 2.15
import QtQuick.Window 2.15

import AntCore 1.0
import AntDivider 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    
    Rectangle {
        width:  parent.width
        height: parent.height
        color: "white"
        Row {
            width: parent.width
            Column {
                spacing: 0
                width: parent.width / 2

                AntDivider {
                    text: "Left Text"
                    orientation: Ant.Left
                }

                AntDivider {
                    text: "Right Text"
                    orientation: Ant.Right
                }

                AntDivider {
                    text: "Left Text"
                    orientation: Ant.Left
                    plain: false
                }

                AntDivider {
                    text: "Right Text"
                    orientation: Ant.Right
                    plain: false
                }

                AntDivider {
                    text: "Left Text margin 50"
                    orientation: Ant.Left
                    plain: false
                    orientationMargin: 50
                }

                AntDivider {
                    text: "Right Text margin 50"
                    orientation: Ant.Right
                    plain: false
                    orientationMargin: 50
                }

                AntDivider {
                    text: "Center"
                    orientation: Ant.Center
                    plain: false
                    orientationMargin: 50
                }

                AntDivider {
                    text: "Center"
                    orientation: Ant.Center
                    plain: false
                    dashed: true
                    orientationMargin: 50
                }
            }

            Row {
                width: parent.width / 2
                height: parent.height
                AntDivider {
                    orientation: Ant.Left
                    type: Ant.Vertical
                    text: "hello"
                }
            }
        }
    }
}
