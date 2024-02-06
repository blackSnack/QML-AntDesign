import QtQuick 2.15

import AntTooltip 1.0
import AntCore 1.0
import AntText 1.0

AntTooltip {
    id: root

    property int titleMinWidth: 177
    property var title: ""
    property Component content: Item {}

    z: 1030
    color: AntTheme.colorBgElevated
    control.width: Math.max(titleMinWidth, implicitWidth)

    contentItem: Column {
        spacing: AntTheme.marginXS
        Loader {
            sourceComponent: title instanceof Component ? title : defaultTitleComponent
        }

        Loader {
            id: contentLoader
            sourceComponent: content
        }
    }

    Component {
        id: defaultTitleComponent

        AntText {
            text: title
            color: AntTheme.colorTextHeading
            font: AntTheme.fontWeightStrong
        }
    }
}
