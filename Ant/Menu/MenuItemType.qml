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
    readonly property int itemLevel: menu.getItemLevel(root.parent)
    readonly property Item ownMenuGroup: menu.getOwnMenuGroup(root.parent)
    
    anchors {
        left: parent.left
        right: parent.right
    }

    height: menu.antStyle.itemHeight

    Row {
        id: content
        enabled: model.disabled === undefined ? true : model.disabled
        leftPadding: itemLevel * AntTheme.margin
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

    ItemBackground {
        id: mouseArea
        property bool checked: menu.selectedKeys.includes(key)

        anchors.fill: parent

        cursorShape: content.enabled ? Qt.ArrowCursor : Qt.ForbiddenCursor
        radius: antStyle.itemBorderRadius
        color: {
            if (!content.enabled) {return "transparent"}
            if (checked) {
                return menu.antStyle.itemSelectedBg
            }
            if (pressed) {
                return menu.antStyle.itemActiveBg
            }

            if (hovered) {
                return menu.antStyle.itemHoverBg
            }
            return "transparent"
        }

        onClicked: {
            if (content.enabled) {
                menu.click(root, key, keyPath)
                menu.selectItem(root)
            }
        }

        onHoveredChanged: content.enabled && hovered ? menu.hovered(root, key, keyPath) : undefined
        onPressed: content.enabled && pressed ? menu.pressed(root, key, keyPath) : undefined
    }

    Component.onCompleted: {
        menu.addChildMenuItem(root)
    }

    Component.onDestruction: {
        menu.removeChildMenuItem(root)
    }
}
