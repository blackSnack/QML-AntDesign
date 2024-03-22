import QtQuick 2.15

import AntCore 1.0
import AntPopover 1.0
import AntText 1.0
import "./Style"
import "./Utils/Utils.js" as Utils

MouseArea {
    id: root

    property color defaultValue
    property color currentColor
    property AntColorPickStyle antStyle: AntColorPickStyle {}
    property var showText: false
    readonly property string value: {
        return Utils.colorFromat(currentColor, defaultFormat)
    }

    property string defaultFormat: "rgb" // [rgb | hex | hsb/hsv]
    property int size: Ant.Middle
    readonly property real __colorRectSize: {
        if (antStyle.size === Ant.Large) {
            return antStyle.sizeLG
        } else if (antStyle.size === Ant.Small) {
            return antStyle.sizeSM
        }
        return antStyle.sizeMI
    }

    implicitWidth: content.width
    implicitHeight: content.height
    hoverEnabled: true

    Rectangle {
        id: content
        readonly property real margins: 4
        readonly property real spacing: 5
        height: __colorRectSize
        width: showText ? layout.width + margins + spacing : __colorRectSize

        color: AntTheme.colorBgContainer
        border.width: AntTheme.lineWidth
        border.color: root.containsMouse || colorPickPopover.visible ? AntTheme.colorPrimaryHover : AntTheme.colorBorder
        radius: {
            if (antStyle.size === Ant.Large) {
                return AntTheme.borderRadiusLG
            } else if (antStyle.size === Ant.Small) {
                return AntTheme.borderRadiusSM
            }
            return AntTheme.borderRadius
        }

        Row {
            id: layout
            spacing: content.spacing
            anchors {
                left: parent.left
                leftMargin: content.margins
                top: parent.top
                topMargin: content.margins
            }
            AntTransparentBg {
                width: __colorRectSize - 8
                height: width

                color: currentColor
                radius: {
                    if (antStyle.size === Ant.Large) {
                        return AntTheme.borderRadius
                    } else if (antStyle.size === Ant.Small) {
                        return AntTheme.borderRadiusXS
                    }
                    return AntTheme.borderRadiusSM
                }
            }

            Loader {
                id: loader
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: {
                    if (typeof showText === "boolean") {
                        return textComp
                    } else if (showText instanceof Component) {
                        return showText
                    }
                    return undefined
                }
            }
            Component {
                id: textComp

                AntText {
                    visible: showText
                    text: root.value
                    antStyle {
                        size: root.antStyle.size
                    }
                }
            }
        }
    }

    AntPopover {
        id: colorPickPopover
        target: root
        trigger: Ant.Click
        contentItem: VericalLayout {
            defaultValue: root.defaultValue

            onCurrentColorChanged: {
                root.currentColor = currentColor
            }
        }
    }
}
