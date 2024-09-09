import QtQuick 2.15

import AntCore 1.0
import AntIcon 1.0

Item {
    required property Item input
    property alias source: icon.source
    property alias color: icon.color
    property alias secondaryColor: icon.secondaryColor

    width: icon.width
    AntIcon {
        id: icon
        anchors {
            verticalCenter: parent.verticalCenter
        }
        height: input.antStyle.fontSize
        width: input.antStyle.fontSize
        color: input.antStyle.prefixColor ?? textField.color
        secondaryColor: input.antStyle.prefixSecondaryColor ? input.antStyle.prefixSecondaryColor : "gray"
    }
}
