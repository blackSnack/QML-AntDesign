import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Templates 2.15 as T
import Qt5Compat.GraphicalEffects

import AntCore 1.0
import AntIcon 1.0
import "./Style"
import "qrc:/AntButton/Utils/Utils.js" as Utils

T.Button
{
    id: root

    property int sizeType: AntButtonStyle.SizeType.Default
    property int type: AntButtonStyle.Type.Default
    property int shape: AntButtonStyle.Shape.Default
    property bool danger: false
    property bool ghost: false
    property bool loading: false
    property bool iconOnly: false
    property var iconSource: icon.source
    property string loadingIcon: "LoadingOutlined"

    property ButtonStyle style: {
        switch (type) {
        case AntButtonStyle.Type.Primary:
            return AntButtonStyle.primaryStyle
        case AntButtonStyle.Type.Dashed:
            return AntButtonStyle.dashedStyle
        case AntButtonStyle.Type.Text:
            return AntButtonStyle.textStyle
        case AntButtonStyle.Type.Link:
            return AntButtonStyle.linkStyle
        case AntButtonStyle.Type.Default:
        default:
            return AntButtonStyle.defaultStyle
        }
    }

    QtObject {
        id: self
        readonly property ButtonSizeStyle sizeStyle: Utils.fetchTargetStyle(sizeType, root.style)
        readonly property var size: Utils.bindCompSize(root, sizeStyle)
        readonly property real implicitWidth: {
            const w = contentItem.contentWidth + leftPadding + rightPadding + implicitIndicatorWidth + spacing
            return self.sizeStyle.compSize.width > w ? self.sizeStyle.compSize.width : w
        }
    }

    implicitWidth: self.size.width
    implicitHeight: self.size.height
    horizontalPadding: self.sizeStyle.paddingInline
    spacing: indicator.visible ? self.sizeStyle.spacing : 0

    indicator: AntIcon {
        id: iconContent
        x: iconOnly ? (root.width - iconContent.width) / 2 : horizontalPadding
        visible: isValid
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: visible ? self.sizeStyle.fontStyle.font.pixelSize : 0
        implicitHeight: visible ? self.sizeStyle.fontStyle.font.pixelSize: 0
        source: loading ? loadingIcon : iconSource
        spin: loading
        color: contentText.color
    }

    background: AntRectangle {
        id: bg
        anchors.fill: parent
        border.width: self.sizeStyle.borderStyle.width
        border.color: Utils.bindStyleStateColor(root, self.sizeStyle.borderStyle)
        border.style: self.sizeStyle.borderStyle.lineStyle
        border.radius: shape === AntButtonStyle.Shape.Default ? self.sizeStyle.borderStyle.radius : self.sizeStyle.borderStyle.roundRadius
        color: Utils.bindStyleStateColor(root, self.sizeStyle.bgStyle)

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 2
            radius: 0
            color: Qt.rgba(0, 0,0, 0.02)
        }
    }

    contentItem: Text {
        id: contentText
        leftPadding: indicator.width + root.spacing
        horizontalAlignment: Text.Center
        verticalAlignment: Text.AlignVCenter
        visible: !iconOnly
        text: root.text
        color: Utils.bindStyleStateColor(root, self.sizeStyle.fontStyle)
        font: self.sizeStyle.fontStyle.font
        lineHeightMode: Text.FixedHeight
        lineHeight: self.sizeStyle.fontStyle.lineHeight
    }
}
