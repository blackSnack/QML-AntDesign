import QtQuick 2.15

import AntCore 1.0
import "./Style"
import "qrc:/AntBadge/Utils/Utils.js" as Utils

Row {
    id: root

    property int dotSize: 6
    property int indicatorHeight: 20
    property int indicatorHeightSM: 14
    property int statusSize: 6
    property int textFontSize: 12
    property int textFontSizeSM: 12
    property int textFontWeight: Font.Normal
    property int overflowCount: 99
    property int count: Number.NaN
    property color color: AntBadgeStyle.colors.red
    property alias text: text.text
    property int status: d.invalidStatus
    property bool dot: false
    property string size: "default" // default | small
    property bool showZero: false

    spacing: AntTheme.marginXS

    Rectangle {
        id: badge
        y: (root.height - badge.height) / 2
        width: d.bgSize.width
        height: d.bgSize.height
        radius: d.bgRadius
        border.width: status !== d.invalidStatus ? 0 : AntTheme.lineWidth
        border.color: AntTheme.colorBgContainer
        color: AntTheme.colorBgContainer

        Rectangle {
            id: processingCycle
            // anchors.centerIn 小数会取整导致有位置偏差
            x: (badge.width - processingCycle.width) / 2
            y: (badge.height - processingCycle.height) / 2
            visible: status === AntBadgeStyle.Status.Processing
            width: d.bgSize.width
            height: d.bgSize.height
            radius: processingCycle.width / 2
            border.width: 2
            border.color: visible ? AntBadgeStyle.statusColors[status] : "transparent"

            ParallelAnimation {
                running: processingCycle.visible
                loops: Animation.Infinite
                NumberAnimation { target: processingCycle; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.OutQuad}
                NumberAnimation{target: processingCycle; property: "opacity"; from: 1; to: 0.1;duration: 1000; easing.type: Easing.OutQuad}
            }
        }

        Rectangle {
            x: (badge.width - width) / 2
            y: (badge.height - height) / 2
            width: d.badgeSize.width
            height: d.badgeSize.height
            radius: d.radius
            color: d.color

            Text {
                id: countText
                anchors.centerIn: parent
                visible: !dot && !Number.isNaN(count) && (count === 0 ? showZero : true)
                text: count > overflowCount ? `${overflowCount}+` : count
                font: d.badgeTextFont
                color: AntTheme.colorTextLightSolid
                leftPadding: countText.text.length > 1 ? AntTheme.paddingXS : 0
                rightPadding: countText.text.length > 1 ? AntTheme.paddingXS : 0
            }
        }
    }

    Text {
        id: text
        y: (root.height - text.height) / 2
        visible: status !== d.invalidStatus
        font: AntTheme.defaultFont
        lineHeight: lineCount > 1 ? AntTheme.lineHeight : 1
        lineHeightMode: Text.ProportionalHeight
    }

    QtObject {
        id: d

        readonly property int invalidStatus: -1
        readonly property real radius: badgeSize.height / 2
        readonly property real bgRadius: bgSize.height / 2
        readonly property font badgeTextFont: Qt.font({
                                                          bold: false,
                                                          underline: false,
                                                          family: AntFont.fontFamily,
                                                          pixelSize: size === "default" ? textFontSize : textFontSizeSM,
                                                          weight: textFontWeight,
                                                      })
        readonly property color color: {
            if (status !== invalidStatus) {
                return AntBadgeStyle.statusColors[status]
            }
            return root.color
        }
        readonly property size bgSize: {
            if (status !== invalidStatus) {
                return Qt.size(badgeSize.width + AntTheme.paddingXS, badgeSize.height + AntTheme.paddingXS)
            }
            return badgeSize
        }
        readonly property size badgeSize: {
            if (status !== invalidStatus) {
                return Qt.size(statusSize, statusSize)
            }
            if (dot) {
                return Qt.size(dotSize, dotSize)
            }
            const w = (size === "default") ? indicatorHeight : indicatorHeightSM;
            const s = Qt.size(w, w)
            return Qt.size(Math.max(s.width, countText.width), s.height)
        }
    }
}
