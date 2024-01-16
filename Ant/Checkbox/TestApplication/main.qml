import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCheckbox 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        ButtonGroup {
            id: childGroup
            exclusive: true
            checkState: parentBox.checkState
        }

        AntCheckbox {
            id: parentBox
            text: qsTr("Parent")
            checkState: childGroup.checkState
        }
        Grid {
            rowSpacing: 10
            columnSpacing: 10
            Repeater {
                model: 20
                AntCheckbox {
                    text: "Hello check box"
                    ButtonGroup.group: childGroup
                }
            }
        }
    }


}
