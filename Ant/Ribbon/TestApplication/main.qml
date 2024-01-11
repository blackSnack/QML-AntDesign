import QtQuick 2.15

import AntCore 1.0
import AntRibbon 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        spacing: 10

        Rectangle {
            id: r1
            width: 100
            height: 40
            radius: 6
            color: "gray"
        }
        Rectangle {
            id: r2
            width: 100
            height: 40
            radius: 6
            color: "gray"
        }
        Rectangle {
            id: r3
            width: 100
            radius: 6
            height: 40
            color: "gray"
        }
        Rectangle {
            id: r4
            width: 100
            radius: 6
            height: 40
            color: "gray"
        }
        Rectangle {
            id: r5
            width: 100
            radius: 6
            height: 40
            color: "gray"
        }

        AntRibbon {
            target: r1
            text: "Hippies"
            color: AntColors.magenta_6
        }

        AntRibbon {
            target: r2
            text: "Hippies"
            color: AntColors.gold_6
        }

        AntRibbon {
            target: r3
            text: "Hippies"
            color: AntColors.green_6
        }

        AntRibbon {
            target: r4
            text: "Hippies"
            color: AntColors.cyan_6
        }

        AntRibbon {
            target: r5
            text: "Hippies"
            color: AntColors.orange_6
        }
    }
}
