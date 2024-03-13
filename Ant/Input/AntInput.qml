import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import "./Style"
import "./Utils/Utils.js" as Utils

FocusScope {
    id: root

    property string placeholder: ""
    property var text: ""
    // 前缀 & 带图标 string | Item | Component
    property var prefix: undefined
    // 后缀 & 带图标 string | Item | Component
    property var suffix: undefined
    // 后缀带标签
    property var addonAfter: undefined
    // 前缀带标签
    property var addonBefore: undefined
    property AntInputStyle antStyle: AntInputStyle {}
    readonly property bool actived: d.actived
    readonly property bool hovered: d.hovered
    readonly property Item mouseLayer: d.mouseLayer
    readonly property bool acceptableInput: d.acceptableInput
    property var validator: null

    property var __styleProxy: new Utils.AntInputStyleProxy(root, antStyle)

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
            addonAfter: root.addonAfter
            addonBefore: root.addonBefore

            content {
                placeholderText: root.placeholder
                verticalAlignment: TextInput.AlignVCenter
                text: root.text
                font.pixelSize: __styleProxy.fontSize
                validator: root.validator

            }
            prefix: root.prefix
            suffix: root.suffix

            Connections {
                target: textField.content

                function onTextEdited () {
                    root.text = textField.content.text
                }
            }
            Component.onCompleted: {
                d.hovered = Qt.binding(_=> {return textField.hovered})
                d.actived = Qt.binding(_=> {return textField.content.activeFocus})
                d.mouseLayer = Qt.binding(_=> {return textField.mouseArea })
                d.acceptableInput = Qt.binding(_=>{return textField.content.acceptableInput})
            }
        }
    }

    QtObject {
        id: d
        property bool actived: false
        property bool hovered: false
        property Item mouseLayer: undefined
        property bool acceptableInput: false
    }
}
