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
    readonly property int iconSize: menu ? menu.antStyle.iconSize : 0

    anchors {
        left: parent.left
        right: parent.right
    }

    height: menu.antStyle.itemHeight

    Row {
        id: content
        enabled: model.disabled === undefined ? true : model.disabled
        anchors {
            left: parent.left
            leftMargin: menu.antStyle.itemPaddingInline
            right: parent.right
            rightMargin: menu.antStyle.itemPaddingInline
            verticalCenter: parent.verticalCenter
        }

        spacing: menu.antStyle.iconMarginInlineEnd

        AntIcon {
            id: icon
            y: (content.height - iconSize) / 2
            visible: source !== undefined && source !== ""
            width: iconSize
            height: iconSize
            source: model.icon
            color: label.color
        }

        AntText {
            id: label
            text: model.label
            color: {
                if (!menu) { return AntColors.gray_13}
                if (!enabled) {
                    return menu.antStyle.itemDisabledColor
                }
                return enabled ? (root.checked ? menu.antStyle.itemSelectedColor : hovered ? menu.antStyle.itemHoverColor : menu.antStyle.itemColor) : menu.antStyle.itemDisabledColor
            }
        }
    }

    MouseArea {
        id: mouseArea
        property bool hovered: false
        property bool checked: false
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: content.enabled ? Qt.ArrowCursor : Qt.ForbiddenCursor

        onEntered: hovered = true
        onExited: hovered = false

        onClicked: {
            if (content.enabled)
                menu.click(root, key, keyPath)
        }

        onHoveredChanged: content.enabled && hovered ? menu.hovered(root, key, keyPath) : undefined
        onPressed: content.enabled && pressed ? menu.pressed(root, key, keyPath) : undefined
    }

    Component.onCompleted: {
        if(menu.selectedKeys.includes(key)) {
            menu.click(root, key, keyPath)
        }
    }
}
