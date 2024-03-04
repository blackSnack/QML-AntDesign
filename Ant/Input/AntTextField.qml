import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0

Rectangle {
    id: root

    property var antStyle: ({})
    property var prefix: undefined
    property var suffix: undefined
    property real leftPadding: __styleProxy.horizontalPadding ?? 0
    property real rightPadding: __styleProxy.horizontalPadding ?? 0
    property real topPadding: __styleProxy.verticalPadding ?? 0
    property real bottomPadding: __styleProxy.verticalPadding ?? 0
    readonly property bool hovered: mouseArea.containsMouse
    readonly property alias content: textField

    border.color: __styleProxy.borderColor(root)
    border.width: AntTheme.lineWidth
    color: root.hovered ? antStyle.hoverBg : antStyle.activeBg
    radius: AntTheme.borderRadius

    Row {
        id: layout
        spacing: 4
        anchors {
            fill: parent
            leftMargin: root.leftPadding
            rightMargin: root.rightPadding
            topMargin: root.topPadding
            bottomMargin: root.bottomPadding
        }

        Loader {
            id: prefixLoader
            height: parent.height
            sourceComponent: {
//                console.log("prefix", root.prefix)
                if (typeof root.prefix === "object") {
                    return prefixIconComp;
                }
                if (typeof root.prefix  === "string") {
                    return prefixTextComp
                }
                return undefined
            }
        }

        T.TextField {
            id: textField
            width: root.width - (root.leftPadding +
                                 root.rightPadding +
                                 prefixLoader.width +
                                 suffixLoader.width)
                   - (prefixLoader.visible > 0 ? layout.spacing : 0)
                   - (suffixLoader.visible > 0 ? layout.spacing : 0)
            height: parent.height
            color: antStyle.textColor
            Text {
                id: placeholder
                anchors.fill: parent
                text: textField.placeholderText
                font: textField.font
                color: AntTheme.colorTextPlaceholder
                visible: !textField.length && !textField.preeditText
                elide: Text.ElideRight
                renderType: textField.renderType
                verticalAlignment: textField.verticalAlignment
            }
            font: AntTheme.defaultFont
            background: Rectangle {
                color: "transparent"
            }
        }

        Loader {
            id: suffixLoader
            height: parent.height
            sourceComponent: {
                if (typeof root.suffix === "object") {
                    return suffixIconComp;
                }
                if (typeof root.suffix  === "string") {
                    return suffixTextComp
                }
                return undefined
            }
        }
    }

    Component {
        id: prefixTextComp

        AntText {
            height: parent.height
            text: root.prefix
            font: antStyle.prefixFont ?? textField.font
            color: antStyle.prefixColor ?? textField.color
        }
    }

    Component {
        id: prefixIconComp
        Item {
            width: icon.width
            AntIcon {
                id: icon
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                height: antStyle.fontSize
                width: antStyle.fontSize
                source: root.prefix.icon ?? ""
                color: antStyle.prefixColor ?? textField.color
                secondaryColor: antStyle.prefixSecondaryColor ? antStyle.prefixSecondaryColor : "gray"
            }
        }
    }

    Component {
        id: suffixTextComp

        AntText {
            height: parent.height
            text: root.suffix
            font: antStyle.prefixFont === undefined ? textField.font : antStyle.prefixFont
            color: antStyle.prefixColor ?? textField.color
        }
    }

    Component {
        id: suffixIconComp
        Item {
            width: icon.width
            AntIcon {
                id: icon
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                height: antStyle.fontSize
                width: antStyle.fontSize
                source: root.suffix.icon ?? ""
                color: antStyle.suffixColor ?? textField.color
                secondaryColor: antStyle.suffixSecondaryColor === undefined ? null : antStyle.suffixSecondaryColor
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true

        hoverEnabled: true

        onPressed: (event)=> event.accepted = false
    }
}
