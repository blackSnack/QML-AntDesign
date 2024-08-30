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
    // Default: false. Type: Component | boolean | JS Object
    property var closeIcon: false

    // Color of the Tag
    // Preset 5 status colors: success | processing | error | default | warning
    // Other preset colors @see: PresetsColors.qml
    property var color: undefined

    // Set the icon of tag
    // Default: null. Type: Component | string "icon source" | JS Object
    property var icon: null

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
            } 
            return isIconVisible(root.closeIcon, closeIconLoader)
        }
        readonly property bool isShowIcon: {
            if (typeof root.icon === "string") {
                return true
            } 
            return isIconVisible(root.icon, iconLoader)   
        }

        function isIconVisible(iconProps, iconLoaderItem) {
             if (iconProps instanceof Component || typeof iconProps === "object") {
                return iconLoaderItem.item ? iconLoaderItem.item.visible : false
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
        spacing: AntTheme.paddingXS
        Item {
            width: d.isShowIcon ? AntTheme.fontSizeIcon : 0
            height: d.isShowIcon ? parent.height: 0

             Loader {
                id: iconLoader
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: {
                    if(!root.icon) {
                        return undefined
                    }
                    if (typeof root.icon === "string") {
                        return iconComp
                    }
                    if (typeof root.icon === "object") {
                        return objectIconComp
                    }
                    if (root.icon instanceof Component) {
                        return root.icon
                    }
                    console.warn(`Cannot support input type for icon! Suggest set type to Component or string. type: ${typeof root.icon}`)
                    return undefined
                }
            }
        }
       
        Row {
            height: parent.height
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
                    id: closeIconLoader
                    width: root.antStyle.iconSize
                    height: root.antStyle.iconSize

                    anchors.verticalCenter: parent.verticalCenter
                    sourceComponent: {
                        if (typeof closeIcon === "boolean") {
                            return closeIcon ? defaultCloseIconComp : undefined
                        } else if (closeIcon instanceof Component) {
                            return closeIcon
                        } else if (typeof icon === "object") {
                            return objectIconComp
                        }
                        
                        console.warn("Cannot support input type for closeIcon! Suggest set type to Component or boolean")
                        return undefined
                    }
                }

                onClicked: {
                    root.visible = false
                    close()
                } 
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

    Component {
        id: iconComp

        AntIcon {
            source: root.icon
            color: PresetsColors.get(root.color).textColor
        }
    }

    Component {
        id: objectIconComp

        AntIcon {
            readonly property var obj: root.icon
            source: obj.source ?? ""
            spin: obj.spin ?? false
            rotate: obj.rotate ?? 0
            color: PresetsColors.get(obj.color ?? root.color).textColor
            secondaryColor: obj.secondaryColor ?? "#D9D9D9"
            sourceWidth: obj.sourceWidth ?? width
            sourceHeight: obj.sourceHeight ?? height
        }
    }
}
