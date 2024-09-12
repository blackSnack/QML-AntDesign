import QtQuick 2.15
import QtQml 2.15

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0

Item {
    id: root

    property var menu: parent.menu
    property var model: parent.model
    property bool opened: false
    property alias iconSource: icon.source
    property alias text: label.text
    property string key: model ? model.key ?? "" : ""
    property alias subMenuView: subMenuView
    property color backgroundColor: menu.antStyle.subMenuItemBg
    property alias actived: subMenuTitle.checked
    readonly property alias pressed: mouseArea.pressed
    readonly property alias hovered: mouseArea.hovered
    readonly property string keyPath: model.keyPath !== undefined ? `${model.keyPath}/${model.key}` : `/${model.key}`
    readonly property int itemHeight: menu.antStyle.itemHeight
    readonly property int iconSize: menu.antStyle.iconSize
    readonly property int itemLevel: menu ? menu.getItemLevel(root.parent) : 0

    width: parent.width
    height: content.height
    clip: false

    Column {
        id: content
        spacing: menu.antStyle.itemMarginBlock
        anchors {
            left: parent.left
            right: parent.right
        }
        // height: itemHeight + subMenuView.height

        Rectangle {
            width: content.width
            height: itemHeight
            radius: menu ? menu.antStyle.itemBorderRadius : 0
            color: "transparent"

            Row {
                id: subMenuTitle
                property bool checked: false
                spacing: menu.antStyle.iconMarginInlineEnd
                x: itemLevel * AntTheme.margin
                anchors {
                    left: parent.left
                    right: parent.right
                    rightMargin: menu ? menu.antStyle.temPaddingInline : 0
                    leftMargin: (menu ? menu.antStyle.itemPaddingInline : 0) + (itemLevel * AntTheme.margin)
                    verticalCenter: parent.verticalCenter
                }

                AntIcon {
                    id: icon
                    y: (subMenuTitle.height - iconSize) / 2
                    visible: source !== undefined && source !== ""
                    width: iconSize
                    height: iconSize
                    source: model ? model.icon : ""
                    color: label.color
                }

                AntText {
                    id: label
                    text: model ? model.label : ""
                    color: enabled ? (subMenuTitle.checked ? AntColors.blue_6 :
                                                             menu.antStyle.itemColor) : menu.antStyle.itemDisabledColor
                }
            }

            AntIcon {
                id: flipable
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: menu.antStyle.itemPaddingInline
                }
                width: iconSize
                height: iconSize
                source: "UpOutlined"
                color: label.color

                SequentialAnimation {
                    running: root.opened
                    PropertyAnimation { target: flipable; property: "height"; to: 6; duration: 50 }
                    PropertyAnimation { target: flipable; property: "source"; to: "DownOutlined"; duration: 0 }
                    PropertyAnimation { target: flipable; property: "height"; to: iconSize; duration: 50 }
                }

                SequentialAnimation {
                    running: !root.opened
                    PropertyAnimation { target: flipable; property: "height"; to: 6; duration: 50 }
                    PropertyAnimation { target: flipable; property: "source"; to: "UpOutlined"; duration: 0 }
                    PropertyAnimation { target: flipable; property: "height"; to: iconSize; duration: 50 }
                }
            }

            ItemBackground {
                id: mouseArea
                anchors.fill: parent
                radius: antStyle.itemBorderRadius
                color: {
                    if (pressed) {
                        return menu.antStyle.itemActiveBg
                    }

                    if (hovered) {
                        return menu.antStyle.itemHoverBg
                    }
                    return "transparent"
                }

                onClicked: {
                    root.opened = !root.opened
                }

                onHoveredChanged: hovered ? menu.hovered(root, key, "") : undefined
                onPressed: pressed ? menu.pressed(root, key, "") : undefined
            }
        }

        ListView {
            id: subMenuView
            interactive: false
            spacing: menu.antStyle.itemMarginBlock
            anchors {
                left: parent.left
                right:parent.right
            }
            visible: height !== 0
            model: root.model.children
            delegate: delegateComp

            Binding {
                target: subMenuView
                when: root.opened
                property: "height"
                value: subMenuView.childrenRect.height
                restoreMode: Binding.RestoreValue
            }
        }

        Component {
            id: delegateComp

            Column {
                width: parent.width
                height: loader.height
                Loader {
                    id: loader
                    readonly property var model: {
                        let tempModelData = modelData
                        tempModelData.keyPath = root.keyPath
                        return tempModelData
                    }
                    readonly property var menu: root.menu
                    width: parent.width
                    sourceComponent: modelData.type === "SubMenu" ? menu.components["NoBgSubMenu"] : menu.components[modelData.type]
                }
            }
        }
    }

    Rectangle {
        y: subMenuView.y
        x: -root.mapToItem(menu, 0, 0).x
        width: menu.width
        height: subMenuView.height
        z: -1
        color: backgroundColor
    }

    Component.onCompleted: {
        root.menu.__submenus.push(root)
    }
}
