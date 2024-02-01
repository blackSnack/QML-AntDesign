import QtQuick 2.15

import AntCore 1.0

import "qrc:/AntCore/Utils/Utils.js" as Utils

ListView {
    id: root

    property bool selectable: true
    readonly property var selectedKeys: d.selectedKeys

    property int itemHeight: 40
    property color itemColor: AntTheme.colorTextHeading
    property color itemDisabledColor: AntTheme.colorTextDisabled
    property int itemPaddingInline: 16
    property int iconSize: 14
    property color itemActiveBg: AntColors.blue_1
    property color itemSelectedBg: AntColors.blue_1
    property color itemBg: AntColors.gray_1
    property color itemHoverBg: AntColors.gray_13_A6
    property color subMenuItemBg: AntColors.gray_13_A2
    property color groupTitleColor: AntColors.gray_13_A45
    property int groupTitleFontSize: 14
    property int itemBorderRadius: 8
    property int itemMarginBlock: 4
    property int itemMarginInline: 4
    property int iconMarginInlineEnd: 10
    property bool multiple: false // not support multiple selected

    property var submenus: []

    property var components: ({
                                  Item: itemType,
                                  SubMenu: subMenu,
                                  NoBgSubMenu: noBgSubMenu,
                                  Group: groupMenu
                              })
    property var backgroundColorStyle: new Utils.ControlColorStyle(
                                           itemBg,
                                           itemBg,
                                           itemActiveBg,
                                           itemSelectedBg,
                                           itemHoverBg,
                                           itemActiveBg
                                           )

    signal click(var item, var key, var keyPath)
    signal select(var item, var key, var keyPath, var selectedKeys)
    signal hovered(var item, var key, var keyPath)
    signal pressed(var item, var key, var keyPath)

    spacing: itemMarginBlock
    height: contentHeight
    delegate: Column {
        width: root.width

        Loader {
            id: loader
            readonly property var model: modelData
            readonly property var menu: root
            width: parent.width
            sourceComponent: {
                if (model.type === "Group") {
                    return groupMenu
                }

                if (model.type === "SubMenu") {
                    return subMenu
                }
                return itemType
            }
        }
    }

    Component {
        id: groupMenu
        MenuItemGroupType { }
    }

    Component {
        id: itemType
        MenuItemType { }
    }

    Component {
        id: subMenu
        SubMenuType { }
    }

    Component {
        id: noBgSubMenu
        SubMenuType {
            backgroundColor: "transparent"
        }
    }

    QtObject {
        id: d

        property var selectedKeys: []

        function addSelectedKey(key) {
            if (!multiple) {
                removeAllSelectedKeys()
                selectedKeys.push(key)
            }else {
                if (selectedKeys.indexOf(key) !== -1) { return }
                selectedKeys.push(key)
            }
        }

        function removeAllSelectedKeys() {
            selectedKeys.forEach((key)=> key.checked = false)
            selectedKeys = []
        }

        function removeSelectedKey(key) {
            let index = selectedKeys.indexOf(key);
            if (index !== -1) {
                key.checked = false
            }
            while (index !== -1) {
                selectedKeys.splice(index, 1);
                index = selectedKeys.indexOf(elementToRemove);
            }
        }

        function updateSubMenuListState(keyPath) {
            let paths = keyPath.split("/")
            submenus.forEach(item=> {
                                 if (paths.includes(item.key)) {
                                     item.actived !== undefined ? item.actived = true : undefined
                                 }else {
                                     item.actived !== undefined ? item.actived = false : undefined
                                 }
                             })
        }
    }

    Rectangle {
        id: highlightItem
        property var currentItem: undefined
        x: itemMarginInline
        width: parent.width - (itemMarginInline * 2)
        height: itemHeight
        radius: itemBorderRadius
        visible: currentItem !== undefined && currentItem.hovered && !currentItem.checked
        color: {
            if (!currentItem || !currentItem.enabled) {return "transparent"}

            if (currentItem.pressed) {
                return itemActiveBg
            }
            if (currentItem.hovered) {
                return itemHoverBg
            }
            return "transparent"
        }
        z: -1
        onCurrentItemChanged: updatePosition(highlightItem)
    }

    Rectangle {
        id: selectedHighlightItem
        property var currentItem: undefined
        x: itemMarginInline
        width: parent.width - (itemMarginInline * 2)
        height: itemHeight
        radius: itemBorderRadius
        visible: currentItem !== undefined && currentItem.visible && currentItem.checked
        color: {
            if (!currentItem || !currentItem.enabled) {return "transparent"}
            if (currentItem.checked) {
                return itemSelectedBg
            }
            return "transparent"
        }
        z: -1

        onCurrentItemChanged: updatePosition(selectedHighlightItem)
    }

    function updatePosition(item) {
        if (!item.currentItem) return;
        const itemPos = item.currentItem.mapToItem(root, 0, 0)
        item.y = itemPos.y
    }

    onContentYChanged: {
        updatePosition(highlightItem)
        updatePosition(selectedHighlightItem)
    }

    onContentHeightChanged: {
        updatePosition(highlightItem)
        updatePosition(selectedHighlightItem)
    }

    onClick: (item, key, keyPath) => {
                 if (selectable && !item.checked) {
                     item.checked = true
                     const itemPos = item.mapToItem(root, 0, 0)
                     selectedHighlightItem.currentItem = item
                     d.addSelectedKey(item)
                     d.updateSubMenuListState(keyPath)
                     select(item, key, keyPath, selectedKeys)
                 } else if (selectable && item.checked && multiple) {
                     d.removeSelectedKey(item)
                 }
             }

    onHovered: (item, key, keyPath) => {
                   if (item) {
                       const itemPos = item.mapToItem(root, 0, 0)
                       highlightItem.y = itemPos.y
                       highlightItem.currentItem = item
                   }
               }
}
