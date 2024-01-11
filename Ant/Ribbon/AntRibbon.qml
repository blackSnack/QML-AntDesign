import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0

Control {
    id: root

    required property Item target
    property int bodyHeight: 22
    property int triangleHeight: 6
    property int triangleWidth: 8
    property alias text: text.text
    property color color: AntColors.blue_6
    property string placement: "end" // [start | end]

    implicitHeight: bodyHeight + triangleHeight
    bottomPadding: triangleHeight
    horizontalPadding: AntTheme.paddingXS

    parent: target
    anchors {
        left: placement === "start" ? target.left : undefined
        right: placement === "start" ? undefined : target.right
        top: target.top
        leftMargin: placement === "start" ? -triangleWidth : 0
        rightMargin: placement === "start" ? 0 : -triangleWidth
        topMargin: (target.height - height) / 2
    }
    contentItem: Text {
        id: text
        verticalAlignment: Text.AlignVCenter
        font: AntTheme.defaultFont
        maximumLineCount: 1
    }

    background: Item {
        AntRectangle {
            id: bodyBg
            width: parent.width
            height: bodyHeight
            border.topLeftRadius: 4
            border.bottomLeftRadius: 4
            border.topRightRadius: 4
            color: root.color
        }
        Canvas {
            width: triangleWidth
            height: triangleHeight
            anchors.top: bodyBg.bottom
            anchors.right: bodyBg.right
            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                ctx.fillStyle = Qt.hsla(root.color.hslHue, root.color.hslSaturation, root.color.hslLightness * 0.7, root.color.a)

                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(0, height)
                ctx.lineTo(width, 0)
                ctx.closePath()
                ctx.fill()
            }
        }
    }
}
