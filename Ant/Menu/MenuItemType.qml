import QtQuick 2.15

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0

Item {
    id: root

    property var menu: parent.menu
    property var model: parent.model

    property alias leftPadding: content.leftPadding
    property alias checked: mouseArea.checked
    readonly property alias pressed: mouseArea.pressed
    readonly property alias hovered: mouseArea.hovered
    property alias iconSource: icon.source
    property alias text: label.text
    property string key: model ? model.key ?? "" : ""
    property string keyPath: model.keyPath ? `${model.keyPath}/${model.key}` : `/${model.key}`

    anchors {
        left: parent.left
        right: parent.right
    }

    height: itemHeight

    Row {
        id: content
        anchors {
            left: parent.left
            leftMargin: menu.itemPaddingInline
            right: parent.right
            rightMargin: menu.itemPaddingInline
            verticalCenter: parent.verticalCenter
        }

        spacing: menu.iconMarginInlineEnd

        AntIcon {
            id: icon
            y: (content.height - iconSize) / 2
            visible: source !== undefined && source !== ""
            width: menu ? menu.iconSize : 0
            height: menu ? menu.iconSize : 0
            source: model.icon
            color: label.color
        }

        AntText {
            id: label
            color: enabled ? (menu ? menu.itemColor : AntColors.gray_13) : menu.itemDisabledColor
            text: model.label
        }
    }

    MouseArea {
        id: mouseArea
        property bool hovered: false
        property bool checked: false
        anchors.fill: parent
        hoverEnabled: true

        onEntered: hovered = true
        onExited: hovered = false

        onClicked: {
            menu.click(root, key, keyPath)
        }

        onHoveredChanged: hovered ? menu.hovered(root, key, keyPath) : undefined
        onPressed: pressed ? menu.pressed(root, key, keyPath) : undefined
    }

    Component.onCompleted: {
        if(menu.selectedKeys.includes(key)) {
            menu.click(root, key, keyPath)
        }
    }
}
