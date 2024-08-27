import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import "./Style"
import "./Utils/Utils.js" as Utils

FocusScope {
    id: root

    property string placeholder: ""
    property string text: ""
    // 前缀 & 带图标 string | Item | Component
    property var prefix: undefined
    // 后缀 & 带图标 string | Item | Component
    property var suffix: undefined
    // 后缀带标签
    property var addonAfter: undefined
    // 前缀带标签
    property var addonBefore: undefined
    property AntInputStyle antStyle: AntInputStyle {}
    readonly property bool actived: textField.content.activeFocus
    readonly property bool hovered: textField.hovered
    readonly property alias mouseLayer: textField.mouseArea
    readonly property bool acceptableInput: textField.content.acceptableInput
    property var validator: null

    property var __styleProxy: new Utils.AntInputStyleProxy(root, antStyle)

    implicitWidth: textField.implicitWidth
    implicitHeight: __styleProxy.controlHeight
    state: "Default" // Default | Error | Warning | Success

    clip: true

    AntTextField {
        id: textField
        anchors.fill: parent
        antStyle: __styleProxy
        addonAfter: root.addonAfter
        addonBefore: root.addonBefore

        content {
            placeholderText: root.placeholder
            verticalAlignment: TextInput.AlignVCenter
            font.pixelSize: __styleProxy.fontSize
            validator: root.validator
            text: root.text
        }
        prefix: root.prefix
        suffix: root.suffix
    }
}
