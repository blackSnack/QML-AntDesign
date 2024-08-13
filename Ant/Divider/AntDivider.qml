import QtQuick 2.15

import AntCore 1.0
import AntText 1.0

import "./Style"
import "qrc:/AntCore/Utils/Utils.js" as CoreUtils

Item {
    id: root

    ///< Whether line is dashed
    property bool dashed: false

    ///< The position of title inside divider.
    ///< Default: Ant.Center
    ///< Support: Ant.Left | Ant.Right | Ant.Center
    property int orientation: Ant.Center

    ///< The margin-left/right between the title and its closest border, while the orientation must be left or right
    ///< Default: undefined
    property var orientationMargin: undefined

    ///< Divider text show as plain style.
    ///< Default: true
    property bool plain: true

    ///< The direction type of divider.
    ///< Default: Ant.Horizontal. 
    ///< Support: Ant.Horizontal | Ant.Vertical
    property int type: Ant.Horizontal

    ///< The text of divider.
    ///< Default: empty
    property string text: ""

    property AntDividerStyle antStyle: AntDividerStyle {}

    implicitHeight: type === Ant.Vertical ? parent.height :(d.textVisible ? textItem.height : d.singleLineHeight )
    implicitWidth: type === Ant.Vertical ? d.verticalWidth : parent.width

    QtObject {
        id: d
        readonly property bool textVisible: textItem.visible
        readonly property int singleLineHeight: AntTheme.lineWidth + AntTheme.marginLG
        readonly property int verticalWidth: AntTheme.lineWidth + AntTheme.margin
    }

    Canvas {
        readonly property point beginLinePoint: orientation === Ant.Left ? (root.orientationMargin !== undefined ? textBeginPoint :  Qt.point(0, height / 2.0)) : Qt.point(0, height / 2.0) 
        readonly property point textBeginPoint: Qt.point(textItem.x, height / 2.0)
        readonly property point textEndPoint: Qt.point(textItem.x + textItem.width, height / 2.0)
        readonly property point endLinePoint: orientation === Ant.Right ? (root.orientationMargin !== undefined ? textEndPoint : Qt.point(width, height / 2.0)) : Qt.point(width, height / 2.0)
        readonly property color lineColor: AntTheme.colorSplit
        readonly property int lineWidth: AntTheme.lineWidth
    
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            ctx.strokeStyle = lineColor; 
            ctx.lineWidth = lineWidth
            if (dashed) {
                ctx.setLineDash([3, 1])
            }
            ctx.beginPath();
            if (type === Ant.Horizontal) {
                ctx.moveTo(beginLinePoint.x, beginLinePoint.y);
                if (d.textVisible) {
                    ctx.lineTo(textBeginPoint.x, textBeginPoint.y)
                    ctx.moveTo(textEndPoint.x, textEndPoint.y)
                }
                ctx.lineTo(endLinePoint.x, endLinePoint.y)
            } else {
                ctx.moveTo(width / 2.0, 0);
                ctx.lineTo(width / 2.0, height)
            }
            ctx.stroke(); 
        }
    }

    AntText {
        id: textItem
        x: {
            if (type === Ant.Horizontal && d.textVisible) {
                var textOrietationMargin = root.orientationMargin === undefined ? root.width * root.antStyle.orientationMargin : root.orientationMargin
                if (orientation === Ant.Left) {
                   return textOrietationMargin
                }
                if (orientation === Ant.Right) {
                    return root.width - textItem.width - textOrietationMargin
                }
                if (orientation === Ant.Center) {
                    return (root.width - textItem.width) / 2.0
                }
            }
            return 0
        }

        anchors.verticalCenter: parent.verticalCenter
        topPadding: AntTheme.margin
        bottomPadding: AntTheme.margin
        leftPadding: CoreUtils.pixels(root.antStyle.textPaddingInline, font)
        rightPadding: CoreUtils.pixels(root.antStyle.textPaddingInline, font)
        text: root.text
        visible: text !== "" && root.type === Ant.Horizontal
        antStyle {
            size: root.plain ? Ant.Middle : Ant.Large
        }
    }
}
