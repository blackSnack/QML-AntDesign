import QtQuick 2.15

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0

Column {
    id: root

    property var menu: parent.menu
    property var model: parent.model
    readonly property var children: model.children

    width: parent.menu.width
    AntText {
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: menu.antStyle.itemPaddingInline
            rightMargin: menu.antStyle.itemPaddingInline
        }
        text: model.label
        color: menu.antStyle.groupTitleColor
        font.pixelSize: menu.antStyle.groupTitleFontSize
    }

    ItemLoader {
        width: root.menu.width
        menu: root.menu
        model: root.children
        opened: true
    }
}
