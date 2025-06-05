import QtQuick 2.15
import AntCore 1.0
import AntIcon 1.0
import AntText 1.0
import AntItem 1.0

import "./Style"

AntItem {
    id: root

    // This attribute defines the alternative text describing the image
    property string alt: ""
    // Letter type unit distance between left and right sides
    property real gap:	4
    // Custom icon type for an icon avatar Component
    property var icon: ""
    // The shape of avatar	circle | square
    property string shape: "circle"
    // The size of the avatar	number | large | small | default | { xs: number, sm: number, ...}
    property var size: "default"
    // The address of the image for an image avatar or image element string | Component
    property var src: ""
    // Whether the picture is allowed to be dragged	boolean | 'true' | 'false'
    property bool draggable: true
    // Handler when img load error, return false to prevent default fallback behavior		-
    property var onError: () => { return false; }
    property AntAvatarStyle antStyle: AntAvatarStyle {}

    implicitWidth: self.controlSize.width
    implicitHeight: self.controlSize.height

    QtObject {
        id: self
        readonly property real radius: {
            if (shape == "circle") {
                return Math.max(width, height) / 2.0
            }
            if (shape == "square") {
                if (size == "large") {
                    return AntTheme.borderRadiusLG
                }
                if (size == "smale") {
                    return AntTheme.borderRadiusSM
                }
                return AntTheme.borderRadius
            }

        }
        readonly property string unavalibleIcon: "UserOutlined"
        readonly property var controlSize: {
            if (typeof size == "string") {
                var s = getContainerSize();
                return  Qt.size(s, s)
            }
            if (typeof size == "number") {
                return  Qt.size(size, size)
            }
            return  Qt.size(0, 0)
        }
        function getContainerSize(){
            if (size == "large") {
                return antStyle.containerSizeLG
            }
            if (size == "small") {
                return antStyle.containerSizeSM
            }
            return antStyle.containerSize
        }

        function getFontSize() {
            if (typeof size == "number") {
                return size / 2.5
            }

            if (size == "large") {
                return antStyle.textFontSizeLG
            }
            if (size == "small") {
                return antStyle.textFontSizeSM
            }
            return antStyle.textFontSize
        }

        function getIconSize(sizeType) {
            if (typeof size == "string") {
                var s = getFontSize();
                return  Qt.size(s, s)
            }
            if (typeof size == "number") {
                return  Qt.size(size / 2.0, size / 2.0)
            }
            return  Qt.size(0, 0)
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: self.radius
        color: {
            if(loader.item.type && loader.item.type === AntIcon.IconType.ImageIcon) {
                return "transparent"
            }
            return antStyle.backgroundColor

        }

        Loader {
            id: loader
            anchors.fill: parent
            clip: true
            sourceComponent: {
                var iconType = typeof root.icon
                if (iconType == "string" && icon === "") {
                    return textComp
                }
                return (typeof iconType == "Component") ? icon : iconComp
            }
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true
        }

        Component {
            id: textComp

            AntText {
                id: antText
                anchors{
                    fill: parent
                    leftMargin: gap
                    rightMargin: gap
                }
                text: textMetrics.elidedText
                font.pixelSize: self.getFontSize()
                fontSizeMode: {
                    if (textMetrics.width <= width) {
                        return Text.FixedSize
                    }
                    return Text.HorizontalFit
                }
                horizontalAlignment: Text.AlignHCenter
                minimumPixelSize: 8
                color: root.antStyle.color

                TextMetrics {
                    id: textMetrics
                    font: antText.font
                    text: root.alt
                    elideWidth: antText.width
                }
            }
        }

        Component {
            id: iconComp
            AntIcon {
                readonly property size iconSize: self.getIconSize(root.size)
                anchors.fill: parent
                source: icon == "" ? self.unavalibleIcon : icon
                sourceWidth: iconSize.width
                sourceHeight: iconSize.height
                color: antStyle.color
            }
        }
    }
}

