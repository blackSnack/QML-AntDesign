import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

import AntCore 1.0
import AntText 1.0

Rectangle {
    id: root

    property var antStyle: ({})
    property var prefix: undefined
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
                if (typeof root.prefix  === "string") {
                    return textComp
                }
            }
            Rectangle {
                id: prefixBg
                anchors.fill: parent
                color: antStyle.addonBg ?? "transparent"
            }
        }

        T.TextField {
            id: textField
            width: root.width - (root.leftPadding + root.rightPadding + prefixLoader.width + layout.spacing)
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
    }

    Component {
        id: textComp

        AntText {
            height: parent.height
            text: root.prefix
            font: antStyle.prefixFont ?? textField.font
            color: antStyle.prefixColor ?? textField.color
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
