import QtQuick 2.15
import Qt5Compat.GraphicalEffects

import AntCore 1.0
import AntSlider 1.0

AntSlider {
    id: slider

    handleSize: 8
    handleSizeHover: handleSize
    handleLineWidthHover: handleLineWidth
    railSize: 8
    handleColor: AntColors.gray_1
    handleActiveColor: handleColor
    handle: AntSliderHandle {
        antStyle: slider.antStyle
        content: Rectangle {
            radius: width / 2
            border.width: hovered ? slider.handleLineWidthHover : slider.handleLineWidth
            border.color: slider.enabled ? slider.handleColor : slider.handleColorDisabled
            color: Qt.hsva(slider.value / slider.max, 1, 1, 1)

            ShadowL1Down {
                target: parent
            }
        }
    }

    rail:  AntSliderRail {
        content: Rectangle {
            radius: height / 2
            LinearGradient {
                anchors.fill: parent
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.hsva(0, 1, 1, 1) }
                    GradientStop { position: 1.0 / 6; color: Qt.hsva(1.0 / 6, 1, 1, 1) }
                    GradientStop { position: (1.0 / 6) * 2; color: Qt.hsva((1.0 / 6) * 2, 1, 1, 1) }
                    GradientStop { position: (1.0 / 6) * 3; color: Qt.hsva((1.0 / 6) * 3, 1, 1, 1) }
                    GradientStop { position: (1.0 / 6) * 4; color: Qt.hsva((1.0 / 6) * 4, 1, 1, 1) }
                    GradientStop { position: (1.0 / 6) * 5; color: Qt.hsva((1.0 / 6) * 5, 1, 1, 1) }
                    GradientStop { position: (1.0 / 6) * 6; color: Qt.hsva((1.0 / 6) * 6, 1, 1, 1) }
                }
            }
        }
    }
}
