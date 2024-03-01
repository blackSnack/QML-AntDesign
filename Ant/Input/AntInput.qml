import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import "./Style"
import "./Utils/Utils.js" as Utils

Item {
    id: root

    property string placeholder: ""
    property string value: ""
    property var prefix: undefined
    property AntInputStyle antStyle: AntInputStyle {}

    readonly property var __styleProxy: new Utils.AntInputStyleProxy(root, antStyle)

    implicitWidth: content.implicitWidth
    implicitHeight: __styleProxy.controlHeight
    state: "Default" // Default | Error | Warning | Success

    clip: true

    Loader {
        id: content
        anchors.fill: parent
        sourceComponent: AntTextField {
            id: textField
            antStyle: __styleProxy

            content {
                placeholderText: root.placeholder
                verticalAlignment: TextInput.AlignVCenter
                text: root.value
                font.pixelSize: __styleProxy.fontSize
            }
            prefix: root.prefix
        }
    }
}
