import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import AntSlider 1.0
import AntCore 1.0

AntSlider {
    id: slider

    property color color
    handleSize: 8
    handleSizeHover: handleSize
    handleLineWidthHover: handleLineWidth
    railSize: 8
    handleColor: AntColors.gray_1
    handleActiveColor: handleColor

    handle: AntSliderHandle {
        style: slider.style
        content: Rectangle {
            radius: width / 2
            border.width: hovered ? slider.handleLineWidthHover : slider.handleLineWidth
            border.color: slider.enabled ? slider.handleColor : slider.handleColorDisabled
            color: Qt.hsva(slider.color.hsvHue,
                           slider.color.hsvSaturation,
                           slider.color.hsvValue,
                           slider.value / slider.max)

            ShadowL1Down {
                target: parent
            }
        }
    }

    rail: AntSliderRail {
        content: AntTransparentBg {
            radius: height / 2
            color: "transparent"

            Item {
                anchors.fill: parent
                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(width, 0)

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.hsva(slider.color.hsvHue,
                                                                     slider.color.hsvSaturation,
                                                                     slider.color.hsvValue,
                                                                     0) }
                        GradientStop { position: 1.0; color: Qt.hsva(slider.color.hsvHue,
                                                                     slider.color.hsvSaturation,
                                                                     slider.color.hsvValue,
                                                                     1) }
                    }
                }
            }
        }
    }
}
