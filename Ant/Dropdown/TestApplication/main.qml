import QtQuick 2.15

import AntDropdown 1.0
import AntMenu 1.0
import AntCore 1.0
import AntButton 1.0
import "qrc:/AntCore/Utils/Utils.js" as AntCoreUtils

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    AntButton {
        id: btn
        x: 100
        y: 100
        text: "Hover me"
    }
    AntDropdown {
        id: dropdown
        target: btn
        placement: Ant.BottomLeft
        menu: [
            AntCoreUtils.getItem("Key_1_B1", "B1", "", [], "Item"),
            AntCoreUtils.getItem("Key_1_B2", "B2", "", [], "Item"),
            AntCoreUtils.getItem("Key_1_B3", "B3", "", [], "Item"),
            AntCoreUtils.getItem("Key_1_B4", "B4", "", [], "Item"),
        ]
    }
}
