import QtQuick 2.15
import QtQuick.Controls 2.15

import AntCore 1.0
import "qrc:/AntCore/Utils/Utils.js" as Utils

MouseArea {
    id: root

    required property Item target
    property bool arrow: true
    property size arrowSize: AntTheme.sizePopupArrow
    property int radius: AntTheme.borderRadius
    property int arrowRadius: AntTheme.borderRadiusXS
    property int placement: Ant.Left
    property alias title: content.text
    property color color: AntTheme.colorBgSpotlight
    property int trigger: Ant.Hover
    property int mouseEnterDelay: 100 // unit ms
    property int mouseLeaveDelay: 100 // unit ms
    property bool defaultOpen: false
    property bool autoPlacement: true
    property bool closeOnPressedOutside: true
    property alias contentItem: control.contentItem
    property alias control: control

    parent: Overlay.overlay
    anchors.fill: parent
    enabled: control.visible
    focus: false
    z: 1070
    propagateComposedEvents: true

    implicitWidth: control.implicitWidth
    implicitHeight: control.implicitHeight

    onPressed: (event)=> {
                   if (closeOnPressedOutside && !d.isContains(event) ) {
                       d.close()
                   }
                   event.accepted = false
               }

    function open() {
        d.open()
    }

    function close() {
        d.close()
    }

    Control {
        id: control

        implicitWidth : implicitContentWidth + leftPadding + rightPadding
        implicitHeight: implicitContentHeight + topPadding + bottomPadding
        bottomPadding: (d.placement >= Ant.Top && d.placement <= Ant.TopRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
        topPadding: (d.placement >= Ant.Bottom && d.placement <= Ant.BottomRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
        leftPadding: (d.placement >= Ant.Right && d.placement <= Ant.RightBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding
        rightPadding: (d.placement >= Ant.Left && d.placement <= Ant.LeftBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding
        parent: Overlay.overlay
        visible: defaultOpen

        contentItem: Text {
            id: content
            verticalAlignment: Text.AlignVCenter
            color: AntTheme.colorTextLightSolid
            font: AntTheme.defaultFont
        }

        background:  Canvas {
            id: canvasBg

            readonly property point leftTopP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(x, y + d.arrowSize.height)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                    return Qt.point(x + d.arrowSize.height, y)
                default:
                    return Qt.point(x, y)
                }
            }
            readonly property point rightTopP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(x + width, y + d.arrowSize.height)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(x + width - d.arrowSize.height, y)
                default:
                    return Qt.point(x + width, y)
                }
            }
            readonly property point leftBottomP: {
                switch (d.placement) {
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                    return Qt.point(x + d.arrowSize.height, y + height)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(x, y + height - d.arrowSize.height)
                default:
                    return Qt.point(x, y + height)
                }
            }
            readonly property point rightBottomP: {
                switch (d.placement) {
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(x + width - d.arrowSize.height, y + height)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(leftBottomP.x + width, leftBottomP.y)
                default:
                    return Qt.point(width, y + height)
                }
            }
            readonly property point arrowStartP: {
                switch (d.placement) {
                case Ant.Bottom:
                    return Qt.point(leftTopP.x + (width - d.arrowSize.width) / 2, leftTopP.y)
                case Ant.BottomLeft:
                    return Qt.point(leftTopP.x + radius + d.arrowTransitionRadius, leftTopP.y)
                case Ant.BottomRight:
                    return Qt.point(rightTopP.x - radius - d.arrowSize.width - d.arrowTransitionRadius, leftTopP.y)
                case Ant.Left:
                    return Qt.point(rightTopP.x, rightTopP.y + (height + d.arrowSize.width) / 2)
                case Ant.LeftTop:
                    return Qt.point(rightTopP.x, rightTopP.y + radius + d.arrowTransitionRadius + d.arrowSize.width)
                case Ant.LeftBottom:
                    return Qt.point(rightBottomP.x, rightBottomP.y - radius - d.arrowTransitionRadius)
                case Ant.Top:
                    return Qt.point(leftBottomP.x + (width + d.arrowSize.width) / 2, leftBottomP.y)
                case Ant.TopLeft:
                    return Qt.point(leftBottomP.x + radius + d.arrowTransitionRadius + d.arrowSize.width, leftBottomP.y)
                case Ant.TopRight:
                    return Qt.point(rightBottomP.x - radius - d.arrowTransitionRadius, rightBottomP.y)
                case Ant.RightTop:
                    return Qt.point(leftTopP.x, leftTopP.y + radius + d.arrowTransitionRadius + d.arrowSize.width)
                case Ant.RightBottom:
                    return Qt.point(leftBottomP.x, leftBottomP.y - radius - d.arrowTransitionRadius)
                case Ant.Right:
                default:
                    return Qt.point(leftTopP.x, leftTopP.y + (height / 2) + d.arrowSize.width / 2)
                }
            }
            readonly property point arrowMidP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowStartP.x + (d.arrowSize.width / 2), y)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(leftTopP.x + width, arrowStartP.y - (d.arrowSize.width / 2))
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowStartP.x - (d.arrowSize.width / 2), leftBottomP.y + d.arrowSize.height)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                default:
                    return Qt.point(0, arrowStartP.y -  (d.arrowSize.width / 2))
                }
            }
            readonly property point arrowMidLP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowMidP.x - d.arrowRadius, y + d.arrowRadius)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y + d.arrowRadius)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowMidP.x + d.arrowRadius, arrowMidP.y - d.arrowRadius)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                default:
                    return Qt.point(d.arrowRadius, arrowMidP.y + d.arrowRadius)
                }
            }
            readonly property point arrowMidRP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowMidP.x + d.arrowRadius, y + d.arrowRadius)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y - d.arrowRadius)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowMidP.x - d.arrowRadius, arrowMidP.y - d.arrowRadius)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                default:
                    return Qt.point(d.arrowRadius, arrowMidP.y - d.arrowRadius)
                }
            }
            readonly property point arrowEndP: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowStartP.x + d.arrowSize.width, leftTopP.y)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(arrowStartP.x, arrowStartP.y - d.arrowSize.width)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowStartP.x - d.arrowSize.width, leftBottomP.y)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                default:
                    return Qt.point(leftTopP.x, arrowMidP.y - (d.arrowSize.width / 2))
                }
            }

            readonly property point startArcToPoint: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowStartP.x - d.arrowTransitionRadius, arrowStartP.y)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(arrowStartP.x, arrowStartP.y + d.arrowTransitionRadius)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowStartP.x + d.arrowTransitionRadius, arrowStartP.y)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
                default:
                    return Qt.point(arrowStartP.x, arrowStartP.y + d.arrowTransitionRadius)
                }
            }

            readonly property point endArcToPoint: {
                switch (d.placement) {
                case Ant.Bottom:
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    return Qt.point(arrowEndP.x + d.arrowTransitionRadius, arrowEndP.y)
                case Ant.Left:
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    return Qt.point(arrowEndP.x, arrowEndP.y - d.arrowTransitionRadius)
                case Ant.Top:
                case Ant.TopLeft:
                case Ant.TopRight:
                    return Qt.point(arrowEndP.x - d.arrowTransitionRadius, arrowEndP.y)
                case Ant.Right:
                case Ant.RightTop:
                case Ant.RightBottom:
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
                ctx.clearRect(0, 0, width, height)
                drawBackground(ctx)
                ctx.restore();
            }

            ShadowL1Down {
                target: canvasBg
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

            readonly property var window: Utils.getRoot(root)
            readonly property size windowSize: Qt.size(window.width, window.height)
            readonly property var windowRect: new Utils.Rect(Qt.rect(0, 0, window.width, window.height))
            readonly property size maxSize: Qt.size(20, 20)
            readonly property size arrowSize: root.arrow ? (root.arrowSize > maxSize ? maxSize : root.arrowSize) : Qt.size(0, 0)
            readonly property int defaultVPadding: AntTheme.paddingSM
            readonly property int defaultHPadding: AntTheme.paddingContentHorizontal
            readonly property int arrowRadius: root.arrowRadius > d.arrowSize.width ? d.arrowSize.width : root.arrowRadius
            readonly property int miniLength: (radius + d.arrowTransitionRadius) * 2 +  d.arrowSize.width
            readonly property int arrowTransitionRadius: radius * 1.5
            readonly property bool isClickTrigger: trigger >= Ant.Click && trigger <= (Ant.Click | Ant.Hover | Ant.Focus)
            property int placement: root.placement
            // target & control
            readonly property var isContains: function(event){
                const point = Qt.point(event.x, event.y)
                return target.contains(target.mapFromItem(null, point)) || control.contains(control.mapFromItem(null, point))
            }
            readonly property bool isClosed: {
                if (control.hovered) { return false }
                switch (trigger) {
                case Ant.Hover | Ant.Focus:
                    return !target.hovered && !target.focus
                case Ant.Hover | Ant.Focus:
                    return !target.hovered && !target.focus
                case Ant.Hover:
                    return !target.hovered
                case Ant.Focus:
                    return !target.focus
                case Ant.Focus:
                default:
                    return !target.focus
                }
            }
            readonly property bool isTriggered: {
                switch (trigger) {
                case Ant.Hover | Ant.Focus:
                    return target.hovered || target.focus
                case Ant.Hover | Ant.Focus:
                    return target.hovered || target.focus
                case Ant.Hover:
                    return target.hovered
                case Ant.Focus:
                    return target.focus
                case Ant.Focus:
                    return target.focus
                }
                return false
            }

            function getRealPlacement() {
                let tempPlacement = root.placement
                if (autoPlacement) {
                    const newPlacement = adjustPlacement()
                    if (newPlacement !== -1) {
                        tempPlacement = newPlacement
                    }
                }
                switch(tempPlacement) {
                case Ant.TopLeft:
                case Ant.TopRight:
                    if (width < d.miniLength) {
                        return Ant.Top
                    }
                    break;
                case Ant.BottomLeft:
                case Ant.BottomRight:
                    if (width < d.miniLength) {
                        return Ant.Bottom
                    }
                    break;
                case Ant.LeftTop:
                case Ant.LeftBottom:
                    if (height < d.miniLength) {
                        return Ant.Left
                    }
                    break;
                case Ant.RightTop:
                case Ant.RightBottom:
                    if (height < d.miniLength) {
                        return Ant.Right
                    }
                    break;
                }
                return tempPlacement
            }

            function adjustPlacement() {
                const rect = getTargetRect()
                let expectArea = getAbsArea(getTargetRect(), root.placement)
                // recalculate
                let newPlacement = -1
                if (!windowRect.contains(expectArea)) {
                    for (var i = 0; i < Ant.RightBottom; i++) {
                        if (i !== 0) {
                            expectArea = getAbsArea(rect, i)
                            if (windowRect.contains(expectArea)) {
                                newPlacement = i
                                break;
                            }
                        }
                    }
                }
                return newPlacement
            }

            function getImplicitSize(placement) {
                const bottomPadding = (placement >= Ant.Top && placement <= Ant.TopRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
                const topPadding = (placement >= Ant.Bottom && placement <= Ant.BottomRight) ? d.arrowSize.height + d.defaultVPadding : d.defaultVPadding
                const leftPadding = (placement >= Ant.Right && placement <= Ant.RightBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding
                const rightPadding = (placement >= Ant.Left && placement <= Ant.LeftBottom) ? d.arrowSize.height + d.defaultHPadding : d.defaultHPadding

                return Qt.size(control.contentItem.width + leftPadding + rightPadding,
                               control.contentItem.height + topPadding + bottomPadding)
            }

            function getAbsArea(targetRect, p) {
                const implSize = getImplicitSize(p)
                switch(p) {
                case Ant.TopLeft:
                    return Qt.rect(targetRect.x, targetRect.y - implSize.height, implSize.width, implSize.height)
                case Ant.TopRight:
                    return Qt.rect(targetRect.rightTop.x - implSize.width, targetRect.rightTop.y - implSize.height, implSize.width, implSize.height)
                case Ant.Top:
                    return Qt.rect(targetRect.leftTop.x + (targetRect.width - implSize.width) / 2, targetRect.rightTop.y - implSize.height, implSize.width, implSize.height)
                case Ant.BottomLeft:
                    return Qt.rect(targetRect.leftBottom.x, targetRect.leftBottom.y, implSize.width, implSize.height)
                case Ant.BottomRight:
                    return Qt.rect(targetRect.rightBottom.x - implSize.width, targetRect.rightBottom.y, implSize.width, implSize.height)
                case Ant.Bottom:
                    return Qt.rect(targetRect.leftBottom.x + (targetRect.width - implSize.width) / 2, targetRect.rightBottom.y, implSize.width, implSize.height)
                case Ant.LeftTop:
                    return Qt.rect(targetRect.x - implSize.width, targetRect.leftTop.y, implSize.width, implSize.height)
                case Ant.LeftBottom:
                    return Qt.rect(targetRect.leftBottom.x - implSize.width, targetRect.leftBottom.y - implSize.height, implSize.width, implSize.height)
                case Ant.Left:
                    return Qt.rect(targetRect.leftBottom.x - implSize.width, targetRect.leftTop.y + (targetRect.height - implSize.height) / 2, implSize.width, implSize.height)
                case Ant.RightTop:
                    return Qt.rect(targetRect.rightTop.x + d.arrowSize.height, targetRect.rightTop.y, implSize.width, implSize.height)
                case Ant.RightBottom:
                    return Qt.rect(targetRect.rightBottom.x + d.arrowSize.height, targetRect.rightBottom.y - implSize.height, implSize.width, implSize.height)
                case Ant.Right:
                    return Qt.rect(targetRect.rightBottom.x + d.arrowSize.height, targetRect.rightTop.y + (targetRect.height - implSize.height) / 2, implSize.width, implSize.height)
                }
                return Qt.rect(0, 0, 0, 0)
            }

            function getTargetRect() {
                const targetLeftTopP = root.target.mapToItem(null, 0, 0)
                return new Utils.Rect(Qt.rect(targetLeftTopP.x, targetLeftTopP.y, root.target.width, root.target.height))
            }

            function updatePoistion() {
                d.placement = getRealPlacement()
                const targetLeftTopP = root.target.mapToItem(null, 0, 0)
                const popupPoint = getAbsArea(getTargetRect(), d.placement)
                control.x = popupPoint.x
                control.y = popupPoint.y
            }

            function open() {
                delayTimer.interval = root.mouseEnterDelay
                delayTimer.triggerHandler = function(){
                    if(!control.visible) {
                        control.visible = true
                    }
                }
                delayTimer.restart()
            }

            function close() {
                delayTimer.interval = root.mouseLeaveDelay
                delayTimer.triggerHandler = function(){
                    if(control.visible) {
                        control.visible = false
                    }
                }
                delayTimer.restart()
            }

            onWindowRectChanged: control.visible ? updatePoistion() : undefined
            onPlacementChanged: control.visible ? canvasBg.requestPaint() : undefined

            onIsTriggeredChanged: isTriggered ? d.open() : undefined
            onIsClosedChanged: isClosed ? d.close() : undefined
        }

        onVisibleChanged: control.visible ? d.updatePoistion() : undefined

        Connections {
            target: root.target

            function onClicked() {
                if (d.isClickTrigger) {
                    control.visible = !control.visible
                }
            }
        }
    }
}
