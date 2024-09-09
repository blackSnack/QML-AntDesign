import QtQuick 2.15

import AntCore 1.0
import AntPopover 1.0
import AntMenu 1.0

AntPopover {
    id: popover

    property LazyItemProxy menu: LazyItemProxy {}
    property var currentSelectedText: []
    property var currentSelectedKey: []

    target: root
    defaultHPadding: 0
    defaultVPadding: 2
    content: AntMenu {
        id: menuItem
        width: popover.control.width
        selectedKeys: currentSelectedKey

        antStyle {
            itemMarginBlock: 0
            itemHeight: AntTheme.controlHeight
        }

        Component.onCompleted: {
            popover.menu.target = menuItem
        }

        onSelect: (item, key, keyPath, selectedItems) => {
                        currentSelectedText = []
                        currentSelectedKey = []
                        selectedItems.forEach((item) => {

                                                 currentSelectedKey.push(item.key)
                                                 currentSelectedText.push(item.text)
                                             })
                        currentSelectedKeyChanged()
                        currentSelectedTextChanged()
                  }
    }
}


