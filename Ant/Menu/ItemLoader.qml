import QtQuick 2.15
import QtQml 2.15

ListView {
    id: root

    property var menu: parent.menu
    property bool opened: false

    spacing: menu.itemMarginBlock
    interactive: false
    anchors {
        left: parent.left
        right:parent.right
        leftMargin: 20
    }
    visible: height !== 0

    delegate: delegateComp

    Component {
        id: delegateComp

        Column {
            width: parent.width
            height: loader.height
            Loader {
                id: loader
                readonly property var model: modelData
                readonly property var menu: root.menu
                width: parent.width
                sourceComponent: menu.components[modelData.type]
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

    Binding {
        target: root
        when: root.opened
        property: "height"
        value: root.childrenRect.height
        restoreMode: Binding.RestoreValue
    }
}
