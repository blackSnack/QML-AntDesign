import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0

Popup {
    id: root

    enum Placement {
        Top,
        TopLeft,
        TopRight,
        Bottom,
        BottomLeft,
        BottomRight,
        Left,
        LeftTop,
        LeftBottom,
        Right,
        RightTop,
        RightBottom
    }
    enum Trigger {
        Hover = 0x1,
        Focus = 0x2,
        Click = 0x4
    }
    required property Item target
    property size arrowSize: AntTheme.sizePopupArrow
    property int radius: AntTheme.borderRadius
    property int arrowRadius: AntTheme.borderRadiusXS
    property int placement: AntTooltip.Placement.Left
    property alias title: content.text
    property color color: AntTheme.colorBgSpotlight
    property int trigger: AntTooltip.Trigger.Hover
    property int mouseEnterDelay: 100 // unit ms
    property int mouseLeaveDelay: 100 // unit ms
    property bool defaultOpen: false

    z: 1070
    implicitWidth : implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    bottomPadding: (d.placement >= AntTooltip.Placement.Top && d.placement <= AntTooltip.Placement.TopRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
    topPadding: (d.placement >= AntTooltip.Placement.Bottom && d.placement <= AntTooltip.Placement.BottomRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
    leftPadding: (d.placement >= AntTooltip.Placement.Right && d.placement <= AntTooltip.Placement.RightBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding
    rightPadding: (d.placement >= AntTooltip.Placement.Left && d.placement <= AntTooltip.Placement.LeftBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding

    parent: target
    visible: defaultOpen

    x: {
        switch (d.placement) {
            // center align
        case AntTooltip.Placement.Bottom:
        case AntTooltip.Placement.Top:
            return -(width - parent.width) / 2
            // left align
        case AntTooltip.Placement.BottomLeft:
        case AntTooltip.Placement.TopLeft:
            return parent.x
            // right align
        case AntTooltip.Placement.BottomRight:
        case AntTooltip.Placement.TopRight:
            return -(width - parent.width)
        case AntTooltip.Placement.Left:
        case AntTooltip.Placement.LeftTop:
        case AntTooltip.Placement.LeftBottom:
            return parent.x - width
        case AntTooltip.Placement.Right:
        case AntTooltip.Placement.RightTop:
        case AntTooltip.Placement.RightBottom:
            return parent.x + parent.width
        default:
            return 0
        }
    }

    y: {
        switch (d.placement) {
        case AntTooltip.Placement.Bottom:
        case AntTooltip.Placement.BottomLeft:
        case AntTooltip.Placement.BottomRight:
            return parent.height
        case AntTooltip.Placement.Top:
        case AntTooltip.Placement.TopLeft:
        case AntTooltip.Placement.TopRight:
            return parent.y - height
        case AntTooltip.Placement.Left:
        case AntTooltip.Placement.Right:
            return -(height - parent.height) / 2
        case AntTooltip.Placement.LeftTop:
        case AntTooltip.Placement.RightTop:
            return parent.y
        case AntTooltip.Placement.LeftBottom:
        case AntTooltip.Placement.RightBottom:
            return -(height - parent.height)
        default:
            return 0
        }
    }

    contentItem: Text {
        id: content
        verticalAlignment: Text.AlignVCenter
        color: AntTheme.colorTextLightSolid
        font: AntTheme.defaultFont
    }

    background:  Canvas {
        id: background

        readonly property point leftTopP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(x, y + d.arrowSize.height)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
                return Qt.point(x + d.arrowSize.height, y)
            default:
                return Qt.point(x, y)
            }
        }
        readonly property point rightTopP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(x + width, y + d.arrowSize.height)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(x + width - d.arrowSize.height, y)
            default:
                return Qt.point(x + width, y)
            }
        }
        readonly property point leftBottomP: {
            switch (d.placement) {
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
                return Qt.point(x + d.arrowSize.height, y + height)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(x, y + height - d.arrowSize.height)
            default:
                return Qt.point(x, y + height)
            }
        }
        readonly property point rightBottomP: {
            switch (d.placement) {
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(x + width - d.arrowSize.height, y + height)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(leftBottomP.x + width, leftBottomP.y)
            default:
                return Qt.point(width, y + height)
            }
        }
        readonly property point arrowStartP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
                return Qt.point(leftTopP.x + (width - d.arrowSize.width) / 2, leftTopP.y)
            case AntTooltip.Placement.BottomLeft:
                return Qt.point(leftTopP.x + radius + d.arrowTransitionRadius, leftTopP.y)
            case AntTooltip.Placement.BottomRight:
                return Qt.point(rightTopP.x - radius - d.arrowSize.width - d.arrowTransitionRadius, leftTopP.y)
            case AntTooltip.Placement.Left:
                return Qt.point(rightTopP.x, rightTopP.y + (height + d.arrowSize.width) / 2)
            case AntTooltip.Placement.LeftTop:
                return Qt.point(rightTopP.x, rightTopP.y + radius + d.arrowTransitionRadius + d.arrowSize.width)
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(rightBottomP.x, rightBottomP.y - radius - d.arrowTransitionRadius)
            case AntTooltip.Placement.Top:
                return Qt.point(leftBottomP.x + (width + d.arrowSize.width) / 2, leftBottomP.y)
            case AntTooltip.Placement.TopLeft:
                return Qt.point(leftBottomP.x + radius + d.arrowTransitionRadius + d.arrowSize.width, leftBottomP.y)
            case AntTooltip.Placement.TopRight:
                return Qt.point(rightBottomP.x - radius - d.arrowTransitionRadius, rightBottomP.y)
            case AntTooltip.Placement.RightTop:
                return Qt.point(leftTopP.x, leftTopP.y + radius + d.arrowTransitionRadius + d.arrowSize.width)
            case AntTooltip.Placement.RightBottom:
                return Qt.point(leftBottomP.x, leftBottomP.y - radius - d.arrowTransitionRadius)
            case AntTooltip.Placement.Right:
            default:
                return Qt.point(leftTopP.x, leftTopP.y + (height / 2) + d.arrowSize.width / 2)
            }
        }
        readonly property point arrowMidP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowStartP.x + (d.arrowSize.width / 2), y)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(leftTopP.x + width, arrowStartP.y - (d.arrowSize.width / 2))
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowStartP.x - (d.arrowSize.width / 2), leftBottomP.y + d.arrowSize.height)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(0, arrowStartP.y -  (d.arrowSize.width / 2))
            }
        }
        readonly property point arrowMidLP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowMidP.x - d.arrowRadius, y + d.arrowRadius)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y + d.arrowRadius)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowMidP.x + d.arrowRadius, arrowMidP.y - d.arrowRadius)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(d.arrowRadius, arrowMidP.y + d.arrowRadius)
            }
        }
        readonly property point arrowMidRP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowMidP.x + d.arrowRadius, y + d.arrowRadius)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y - d.arrowRadius)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y - d.arrowRadius)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(d.arrowRadius, arrowMidP.y - d.arrowRadius)
            }
        }
        readonly property point arrowEndP: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowStartP.x + d.arrowSize.width, leftTopP.y)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(arrowStartP.x, arrowStartP.y - d.arrowSize.width)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowStartP.x - d.arrowSize.width, leftBottomP.y)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(leftTopP.x, arrowMidP.y - (d.arrowSize.width / 2))
            }
        }

        readonly property point startArcToPoint: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowStartP.x - d.arrowTransitionRadius, arrowStartP.y)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(arrowStartP.x, arrowStartP.y + d.arrowTransitionRadius)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowStartP.x + d.arrowTransitionRadius, arrowStartP.y)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(arrowStartP.x, arrowStartP.y + d.arrowTransitionRadius)
            }
        }

        readonly property point endArcToPoint: {
            switch (d.placement) {
            case AntTooltip.Placement.Bottom:
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                return Qt.point(arrowEndP.x + d.arrowTransitionRadius, arrowEndP.y)
            case AntTooltip.Placement.Left:
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                return Qt.point(arrowEndP.x, arrowEndP.y - d.arrowTransitionRadius)
            case AntTooltip.Placement.Top:
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                return Qt.point(arrowEndP.x - d.arrowTransitionRadius, arrowEndP.y)
            case AntTooltip.Placement.Right:
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
            default:
                return Qt.point(arrowEndP.x, arrowEndP.y - d.arrowTransitionRadius)
            }
        }

        function drawBackground(ctx) {
            ctx.beginPath()

            // draw arrow
            ctx.moveTo(startArcToPoint.x, startArcToPoint.y)
            ctx.arcTo(arrowStartP.x, arrowStartP.y,  arrowMidLP.x, arrowMidLP.y, d.arrowTransitionRadius)
            ctx.lineTo(arrowMidLP.x, arrowMidLP.y)
            ctx.arcTo(arrowMidP.x, arrowMidP.y, arrowMidRP.x, arrowMidRP.y, d.arrowRadius);
            ctx.arcTo(arrowEndP.x, arrowEndP.y, endArcToPoint.x, endArcToPoint.y, d.arrowTransitionRadius)

            // draw rectangle
            ctx.moveTo(leftTopP.x, leftTopP.y + radius)
            ctx.arcTo(leftTopP.x, leftTopP.y, leftTopP.x + radius, leftTopP.y, radius)
            ctx.lineTo(rightTopP.x - radius, rightTopP.y)
            ctx.arcTo(rightTopP.x, rightTopP.y, rightTopP.x, rightTopP.y + radius, radius)
            ctx.lineTo(rightBottomP.x, rightBottomP.y - radius)
            ctx.arcTo(rightBottomP.x, rightBottomP.y, rightBottomP.x - radius, rightBottomP.y, radius)
            ctx.lineTo(leftBottomP.x + radius, leftBottomP.y)
            ctx.arcTo(leftBottomP.x, leftBottomP.y, leftBottomP.x, leftBottomP.y - radius, radius)

            ctx.closePath()
            ctx.fillStyle = root.color;
            ctx.fill();
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.save();
            drawBackground(ctx)
            ctx.restore();
        }
    }

    Timer {
        id: delayTimer
        property var triggerHandler: undefined
        repeat: false
        running: false
        onTriggered: {
            if (triggerHandler) {
                triggerHandler()
            }
        }
    }

    QtObject {
        id: d

        readonly property size maxSize: Qt.size(20, 20)
        readonly property size arrowSize: root.arrowSize > maxSize ? maxSize : root.arrowSize
        readonly property int defaultVPadding: AntTheme.paddingSM
        readonly property int defaultHPadding: AntTheme.paddingContentHorizontal
        readonly property int arrowRadius: root.arrowRadius > d.arrowSize.width ? d.arrowSize.width : root.arrowRadius
        readonly property int miniLength: (radius + d.arrowTransitionRadius) * 2 +  d.arrowSize.width
        readonly property int arrowTransitionRadius: radius * 1.5
        readonly property int placement: {
            switch(root.placement) {
            case AntTooltip.Placement.TopLeft:
            case AntTooltip.Placement.TopRight:
                if (width < miniLength) {
                    return AntTooltip.Placement.Top
                }
                break;
            case AntTooltip.Placement.BottomLeft:
            case AntTooltip.Placement.BottomRight:
                if (width < miniLength) {
                    return AntTooltip.Placement.Bottom
                }
                break;
            case AntTooltip.Placement.LeftTop:
            case AntTooltip.Placement.LeftBottom:
                if (height < miniLength) {
                    return AntTooltip.Placement.Left
                }
                break;
            case AntTooltip.Placement.RightTop:
            case AntTooltip.Placement.RightBottom:
                if (height < miniLength) {
                    return AntTooltip.Placement.Right
                }
                break;
            }
            return root.placement
        }

        readonly property bool isVisible: {
            switch (trigger) {
            case AntTooltip.Trigger.Hover | AntTooltip.Trigger.Focus:
                return target.hovered | target.focus
            case AntTooltip.Trigger.Hover | AntTooltip.Trigger.Focus:
                return target.hovered | target.focus
            case AntTooltip.Trigger.Hover:
                return target.hovered
            case AntTooltip.Trigger.Focus:
                return target.focus
            case AntTooltip.Trigger.Focus:
                return target.focus
            }
            return false
        }

        onIsVisibleChanged: {
            if(isVisible) {
                delayTimer.interval = root.mouseEnterDelay
                delayTimer.triggerHandler = function(){
                    if(!root.opened) {
                        root.open()
                    }
                }
            }else {
                delayTimer.interval = root.mouseLeaveDelay
                delayTimer.triggerHandler = function(){
                    if(root.opened) {
                        root.close()
                    }
                }
            }
            delayTimer.restart()
        }
    }

    Connections {
        target: parent

        function onClicked() {
            if (trigger >= AntTooltip.Trigger.Click && trigger <= AntTooltip.Trigger.Click | AntTooltip.Trigger.Hover | AntTooltip.Trigger.Focus) {
                root.open()
            }
        }
    }
}

