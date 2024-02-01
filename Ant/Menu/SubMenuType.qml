import QtQuick 2.15

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
    property color backgroundColor: menu.subMenuItemBg
    property alias actived: subMenuTitle.checked
    readonly property alias pressed: mouseArea.pressed
    readonly property alias hovered: mouseArea.hovered
    readonly property string keyPath: model.keyPath !== undefined ? `${model.keyPath}/${model.key}` : `/${model.key}`

    width: parent.width
    height: content.height
    clip: false

    Column {
        id: content
        spacing: menu.itemMarginBlock
        anchors {
            left: parent.left
            right: parent.right
        }
        height: itemHeight + subMenuView.height

        Rectangle {
            width: content.width
            height: itemHeight
            radius: menu ? menu.itemBorderRadius : 0
            color: "transparent"

            Row {
                id: subMenuTitle
                property bool checked: false
                spacing: menu.iconMarginInlineEnd
                anchors {
                    left: parent.left
                    right: parent.right
                    rightMargin: menu ? menu.itemPaddingInline : 0
                    leftMargin: menu ? menu.itemPaddingInline : 0
                    verticalCenter: parent.verticalCenter
                }

                AntIcon {
                    id: icon
                    y: (subMenuTitle.height - iconSize) / 2
                    visible: source !== undefined && source !== ""
                    width: menu ? menu.iconSize : 0
                    height: menu ? menu.iconSize : 0
                    source: model ? model.icon : ""
                    color: label.color
                }

                AntText {
                    id: label
                    text: model ? model.label : ""
                    color: enabled ? (subMenuTitle.checked ? AntColors.blue_6 :
                                                             menu.itemColor) : menu.itemDisabledColor
                }
            }

            AntIcon {
                id: flipable
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: menu.itemPaddingInline
                }
                width: menu.iconSize
                height: menu.iconSize
                source: "UpOutlined"
                color: label.color

                SequentialAnimation {
                    running: root.opened
                    PropertyAnimation { target: flipable; property: "height"; to: 6; duration: 50 }
                    PropertyAnimation { target: flipable; property: "source"; to: "DownOutlined"; duration: 0 }
                    PropertyAnimation { target: flipable; property: "height"; to: menu.iconSize; duration: 50 }
                }

                SequentialAnimation {
                    running: !root.opened
                    PropertyAnimation { target: flipable; property: "height"; to: 6; duration: 50 }
                    PropertyAnimation { target: flipable; property: "source"; to: "UpOutlined"; duration: 0 }
                    PropertyAnimation { target: flipable; property: "height"; to: menu.iconSize; duration: 50 }
                }
            }

            MouseArea {
                id: mouseArea
                property bool hovered: false
                anchors.fill: parent
                hoverEnabled: true

                onEntered: hovered = true
                onExited: hovered = false

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
            spacing: menu.itemMarginBlock
            anchors {
                left: parent.left
                right:parent.right
                leftMargin: AntTheme.margin
            }
            visible: height !== 0
            height: {
                if (!root.opened) {return 0}
                let h = 0
                children.forEach(item=>{h+= item.height})
                return h
            }
            model: root.model.children

            delegate: delegateComp
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

        Component {
            id: d1

            MenuItemType {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                leftPadding: AntTheme.margin
                menu: root.menu
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
        root.menu.submenus.push(root)
    }
}
