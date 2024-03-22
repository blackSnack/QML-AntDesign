import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Templates 2.15 as T

import AntCore 1.0

Item {
    id: root

    property var defaultValue: 0
    property color railBg: AntColors.gray_13_A4
    property color railHoverBg: AntColors.gray_13_A6
    property int railSize: 4
    property color trackBg: AntColors.blue_3
    property color trackBgDisabled: AntColors.gray_13_A4
    property color trackHoverBg: AntColors.blue_4
    property bool vertical: false
    property bool disabled: false
    property real max: 100
    property real min: 0
    property real step: 1
    property real value: min

    property int handleSize: 10
    property int handleSizeHover: 12
    property int handleLineWidth: 2
    property int handleLineWidthHover: 4
    property color handleColor: AntColors.blue_3
    property color handleActiveColor: AntColors.blue_6
    property color handleColorDisabled: AntColors.gray_6

    property var antStyle: ({
                            handleSize: root.handleSize,
                            handleLineWidth: root.handleLineWidth,
                            handleLineWidthHover: root.handleLineWidthHover,
                            handleSizeHover: root.handleSizeHover
                         })

    property Component rail: AntSliderRail {
        hoverEnabled: root.enabled
        content: Rectangle {
            radius: height / 2
            color: root.enabled ? (hovered ? railHoverBg : railBg) : trackBgDisabled

            Rectangle {
                width: root.vertical ? parent.width : d.visualPosition * parent.width
                height: root.vertical ? d.visualPosition * parent.height : parent.height
                color: root.enabled ? (hovered ? trackHoverBg : trackBg) : trackBgDisabled
                radius: parent.radius
            }
        }
    }
    property Component handle: AntSliderHandle {
        antStyle: root.antStyle
        hoverEnabled: root.enabled
        content: Rectangle {
            radius: width / 2
            border.width: hovered ? handleLineWidthHover : handleLineWidth
            border.color: root.enabled ? (hovered ? handleActiveColor : handleColor) : handleColorDisabled
            color: AntTheme.colorBgElevated
        }
    }

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    enabled: !disabled

    QtObject {
        id: d

        property real visualPosition: 0
        property real handleMaxSize: Math.max(handleSizeHover + handleLineWidthHover * 2, handleSize + handleLineWidth * 2)
    }

    Loader {
        id: content
        sourceComponent: sliderComp
    }

    Component {
        id: sliderComp
        T.Slider {
            id: slider
            from: root.min
            to: root.max

            implicitWidth: root.vertical ? Math.max(background.implicitWidth, d.handleMaxSize) : root.width
            implicitHeight: root.vertical ? root.height : Math.max(background.implicitHeight, d.handleMaxSize)
            orientation: root.vertical ? Qt.Vertical : Qt.Horizontal

            pressed: handleLoader.item.hovered
            background: Loader {
                x: root.vertical ? (slider.leftPadding + slider.availableWidth / 2 - width / 2) : slider.leftPadding + d.handleMaxSize / 2
                y: root.vertical ? slider.topPadding + d.handleMaxSize / 2 : (slider.topPadding + slider.availableHeight / 2 - height / 2)
                width: root.vertical ? railSize : slider.implicitWidth - d.handleMaxSize
                height: root.vertical ? slider.implicitHeight - d.handleMaxSize : railSize
                sourceComponent: rail
            }

            handle: Item {
                x: root.vertical ? (slider.leftPadding + slider.availableWidth / 2 - width / 2) : (slider.leftPadding + slider.visualPosition * ( slider.availableWidth - width))
                y: root.vertical ? (slider.topPadding + slider.visualPosition* ( slider.availableHeight - height)) : (slider.topPadding + slider.availableHeight / 2 - height / 2)
                implicitWidth: handleLoader.width
                implicitHeight: handleLoader.height
                Loader {
                    id: handleLoader
                    sourceComponent: root.handle
                }
            }

            onActiveFocusChanged: {
                // 强制handle获取焦点
                handleLoader.item.forceActiveFocus()
            }

            onVisualPositionChanged: d.visualPosition = visualPosition
            // onValueChanged: root.value = value
            value: root.value

            Connections {
                target: root

                function onValueChanged() { slider.value = root.value }
            }

            Connections {
                target: slider

                function onValueChanged() { root.value = slider.value }
            }
        }
    }
}
