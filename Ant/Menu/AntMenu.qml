import QtQuick 2.15

import AntCore 1.0

import "./Style"
import "qrc:/AntCore/Utils/Utils.js" as Utils

ListView {
    id: root

    property bool selectable: true
    readonly property var selectedItems: d.selectedItems
    property var selectedKeys: []
    property bool multiple: false

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

    onSelectedKeysChanged: Qt.callLater(d.syncSelectedItem)

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
        property var itemMap: new Map()

        onItemMapChanged: {
            Qt.callLater(syncSelectedItem)
        }

        function syncSelectedItem() {
            if(root.selectedKeys.length === 0 || itemMap.size === 0) {
                removeAllselectedItems();
                return
            }

            for(var i = 0; i < root.selectedKeys.length; i++) {
                if (itemMap.has(root.selectedKeys[i])) {
                    let item = itemMap.get(root.selectedKeys[i])
                    if (!item.checked) {
                        selectItem(item)
                    }
                }
            }
        }

        function addSelectedItem(item) {
            if (!multiple) {
                item.checked = true
                removeAllselectedItems()
                selectedItems.push(item)
            }else {
                item.checked = !item.checked
                if (item.checked) {
                    if (selectedItems.indexOf(item) !== -1) { return }
                    selectedItems.push(item)
                } else {
                    removeSelectedKey(item)
                }
            }
            console.log("addSelectedItem ", item.key, selectedItems.length)
            d.updateSubMenuListState()

            var selectedKeys = []
            // sync selected items
            for (var i = 0; i < selectedItems.length; i++) {
                selectedKeys.push(selectedItems[i].key)
            }
            // sync property
            root.selectedKeys = selectedKeys
            Qt.callLater(selectedItemsChanged)
        }

        function removeAllselectedItems() {
            selectedItems.forEach((key)=> key.checked = false)
            selectedItems = []
            Qt.callLater(selectedItemsChanged)
        }

        function removeSelectedKey(item) {
            let index = selectedItems.indexOf(item);
            if (index !== -1) {
                item.checked = false
                // remove item
                selectedItems.splice(index, 1)
                Qt.callLater(selectedItemsChanged)
            }
        }

        function updateSubMenuListState() {
            var selectedKeys = []
            __submenus.forEach(item=> {
                                    item.actived = false
                                    for(var i = 0; i < selectedItems.length; i++) {
                                        // sync sub menu actived status
                                        let keyPath = selectedItems[i].keyPath
                                        let paths = keyPath.split("/")
                                        if (paths.includes(item.key)) {
                                            item.actived !== undefined ? item.actived = true : undefined
                                            return;
                                        }else {
                                            item.actived !== undefined ? item.actived = false : undefined
                                        }
                                    } 
                              })
        }
    }

    function getItemLevel(item, level = 0) {
        if (item == null || item instanceof AntMenu) {
            return level
        }
        if (item instanceof SubMenuType || item instanceof MenuItemGroupType) 
        {
            return getItemLevel(item.parent, level + 1)
        }
        return getItemLevel(item.parent, level)
    }

    function getOwnMenuGroup(item) {
        if (item == null || item instanceof AntMenu) {
            return null
        }

        if (item instanceof SubMenuType || item instanceof MenuItemGroupType) {
            return item
        }
        return getOwnMenuGroup(item.parent)
    }

    function addChildMenuItem(item) {
        d.itemMap.set(item.key, item)
    }

    function removeChildMenuItem(item) {
        d.itemMap.delete(item.key)
    }

    function selectItem(item) {
        if(selectable) {
            d.addSelectedItem(item)
        }
    }
}
