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
    property LazyItemProxy contentItem: LazyItemProxy {}
    readonly property bool actived: contentItem.target ? contentItem.target.content.activeFocus : false
    readonly property bool hovered: contentItem.target ? contentItem.target.hovered : false
    readonly property Item mouseLayer: contentItem.target ? contentItem.target.mouseArea : null
    readonly property bool acceptableInput: contentItem.target ? contentItem.target.content.acceptableInput : false
    property var validator: null
    property bool readOnly: false
    property Component delegate: defaultInputDelegate

    property var __styleProxy: new Utils.AntInputStyleProxy(root, antStyle)

    implicitWidth: textField.implicitWidth
    implicitHeight: __styleProxy.controlHeight
    state: "Default" // Default | Error | Warning | Success

    clip: true

    Loader {
        id: contentLoader
        anchors.fill: parent

        sourceComponent: delegate

        onItemChanged: {
            contentItem.target = contentLoader.item
        }
    }

    Component {
        id: defaultInputDelegate
        AntTextField {
            id: textField
            antStyle: __styleProxy
            addonAfter: root.addonAfter
            addonBefore: root.addonBefore

            content {
                placeholderText: root.placeholder
                verticalAlignment: TextInput.AlignVCenter
                font.pixelSize: __styleProxy.fontSize
                validator: root.validator
                text: root.text
                readOnly: root.readOnly
            }
            prefix: root.prefix
            suffix: root.suffix
        }
    }
}
