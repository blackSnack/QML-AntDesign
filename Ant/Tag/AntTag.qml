import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import AntText 1.0
import AntIcon 1.0
import "./Style"

Control {
    id: root

    // Set the text of tag
    required property string text

    // Custom close icon.
    // Close button will be hidden when setting to null or false
    // Default: false. Type: Component | boolean
    property var closeIcon: false

    // Color of the Tag
    property var color: undefined

    // Set the icon of tag
    property Item icon: null

    // Whether has border style
    property bool bordered: true

    property var antStyle: AntTagStyle {}

    // Callback executed when tag is closed
    signal close()

    QtObject {
        id: d
        readonly property bool isShowCloseIcon: {
            if (typeof closeIcon === "boolean") {
                return closeIcon
            } else if (closeIcon instanceof Component) {
                return iconLoader.item.visible
            }
            return false
        }
    }

    height: antStyle.height
    horizontalPadding: AntTheme.paddingXS

    background: AntRectangle {
        color: root.color ? PresetsColors.get(root.color).bgColor : antStyle.defaultBg
        border {
            radius: AntTheme.borderRadiusSM
            color: root.color ? PresetsColors.get(root.color).borderColor :AntTheme.colorBorder
            width: bordered ? AntTheme.lineWidth : 0
        }
    }
    contentItem: Row {
        spacing: AntTheme.paddingXXS
        AntText {
            height: parent.height
            font: AntFont.reuglar12
            text: root.text
            color: root.color ? PresetsColors.get(root.color).textColor : root.antStyle.defaultColor
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            height: d.isShowCloseIcon ? parent.height : 0
            width: d.isShowCloseIcon ? root.antStyle.iconSize : 0
            cursorShape: Qt.PointingHandCursor

            Loader {
                id: iconLoader
                width: root.antStyle.iconSize
                height: root.antStyle.iconSize

                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: {
                    if (typeof closeIcon === "boolean") {
                        return closeIcon ? defaultCloseIconComp : undefined
                    } else if (closeIcon instanceof Component) {
                        return closeIcon
                    }
                    
                    console.warn("Cannot support input type for closeIcon! Suggest set typee for Component or boolean")
                    return undefined
                }
            }

            onClicked: {
                root.visible = false
                close()
            } 
        } 
    }

    Component {
        id: defaultCloseIconComp

        AntIcon {
            source: "CloseOutlined"
            color: AntTheme.colorTextDescription
        }
    } 
}
