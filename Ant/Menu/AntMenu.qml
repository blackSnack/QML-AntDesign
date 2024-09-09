import QtQuick 2.15

import AntCore 1.0

import "./Style"
import "qrc:/AntCore/Utils/Utils.js" as Utils

ListView {
    id: root

    property bool selectable: true
    readonly property var selectedItems: d.selectedItems
    property var selectedKeys: []
    property bool multiple: false // not support multiple selected
    // export mode alias as items
    // property alias items: mode

    property AntMenuStyle antStyle: AntMenuStyle {}

    property var __submenus: []

    property var components: ({
                                  Item: itemType,
                                  SubMenu: subMenu,
                                  NoBgSubMenu: noBgSubMenu,
                                  Group: groupMenu
                              })
    property var backgroundColorStyle: new Utils.ControlColorStyle(
                                           antStyle.itemBg,
                                           antStyle.itemBg,
                                           antStyle.itemActiveBg,
                                           antStyle.itemSelectedBg,
                                           antStyle.itemHoverBg,
                                           antStyle.itemActiveBg
                                           )

    signal click(var item, var key, var keyPath)
    signal select(var item, var key, var keyPath, var selectedItems)
    signal hovered(var item, var key, var keyPath)
    signal pressed(var item, var key, var keyPath)

    objectName: "ANT_MENU"
    spacing: antStyle.itemMarginBlock
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

        property var selectedItems: []

        function addSelectedItem(key) {
            if (!multiple) {
                removeAllselectedItems()
                selectedItems.push(key)
            }else {
                if (selectedItems.indexOf(key) !== -1) { return }
                selectedItems.push(key)
            }
        }

        function removeAllselectedItems() {
            selectedItems.forEach((key)=> key.checked = false)
            selectedItems = []
        }

        function removeSelectedKey(key) {
            let index = selectedItems.indexOf(key);
            if (index !== -1) {
                key.checked = false
            }
            while (index !== -1) {
                selectedItems.splice(index, 1);
                index = selectedItems.indexOf(elementToRemove);
            }
        }

        function updateSubMenuListState(keyPath) {
            let paths = keyPath.split("/")
            __submenus.forEach(item=> {
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
        x: antStyle.itemMarginInline
        width: parent.width - (antStyle.itemMarginInline * 2)
        height: antStyle.itemHeight
        radius: antStyle.itemBorderRadius
        visible: currentItem !== undefined && currentItem.hovered && !currentItem.checked
        color: {
            if (!currentItem || !currentItem.enabled) {return "transparent"}

            if (currentItem.pressed) {
                return antStyle.itemActiveBg
            }
            if (currentItem.hovered) {
                return antStyle.itemHoverBg
            }
            return "transparent"
        }
        z: -1
        onCurrentItemChanged: updatePosition(highlightItem)
    }

    Rectangle {
        id: selectedHighlightItem
        property var currentItem: undefined
        x: antStyle.itemMarginInline
        width: parent.width - (antStyle.itemMarginInline * 2)
        height: antStyle.itemHeight
        radius: antStyle.itemBorderRadius
        visible: currentItem !== undefined && currentItem.visible && currentItem.checked
        color: {
            if (!currentItem || !currentItem.enabled) {return "transparent"}
            if (currentItem.checked) {
                return antStyle.itemSelectedBg
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
                     d.addSelectedItem(item)
                     d.updateSubMenuListState(keyPath)
                     select(item, key, keyPath, selectedItems)
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
