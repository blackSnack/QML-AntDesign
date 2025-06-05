import QtQuick 2.15
import AntCore 1.0
import AntSpace 1.0
import AntTooltip 1.0
import "./Style"

Row {
    id: root

    // Set the maximum number of displayed related configurations
    property AntAvatarMaxObject max: AntAvatarMaxObject{}
    // Set the size of the avatar number | large | small | default | { xs: number, sm: number, ...}
    property var size: "default"
    // Set the shape of the avatar	circle | square	circle
    property string shape: "circle"
    property AntAvatarStyle antStyle: AntAvatarStyle {}

    default property alias content: layout.children

    spacing: antStyle.groupOverlapping

    QtObject {
        id: self
        readonly property bool enabledMax: (max.count > 0)
        function update() {
            for(var i = 0; i < layout.visibleChildren.length; i++) {
                let item = layout.visibleChildren[i]
                item.shape = Qt.binding(()=>{return root.shape})
                item.size = Qt.binding(()=>{return root.size})
                if (enabledMax && i >= max.count) {
                    item.parent = tooltipContent
                } else {
                    item.parent = layout
                }
            }
        }
    }

    Row {
        id: layout
        objectName: "AntAvatarGroupLayout"
        spacing: root.spacing

        onVisibleChildrenChanged: {
            self.update()
        }
    }

    AntAvatar {
        id: moreAvatar
        visible: self.enabledMax && tooltipContent.children.length > 0
        size: root.size
        shape: root.shape
        hoverEnabled: true
        antStyle {
            backgroundColor: max.style.backgroundColor ?? root.antStyle.backgroundColor
            color: max.style.color ?? root.antStyle.color
        }
        alt: `+${tooltipContent.children.length}`

        AntTooltip {
            target: moreAvatar
            placement: Ant.Top
            defaultHPadding: AntTheme.paddingSM
            color: AntTheme.colorBgContainer

            control.contentItem: AntSpace {
                id: tooltipContent
                size: 4
            }
        }
    }

    onMaxChanged: {
        if (!self.enabledMax) {
            return;
        }
        self.update()
    }
}
