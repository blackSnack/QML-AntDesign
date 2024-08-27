// MIT License
// Copyright (c) 2024 Karl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
import QtQuick 2.15

import AntQtCompat.GraphicalEffects 1.0

Item {
    id: root

    property color color
    property real radius: 10
    readonly property alias currentColor: handle.color

    implicitWidth: 256
    implicitHeight: 160
    layer.enabled: true
    layer.effect: CompatOpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: root.radius
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: Qt.hsva(Math.max(root.color.hsvHue, 0), 1, 1, 1)

        CompatLinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(0, 0)
            end: Qt.point(width, 0)

            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 1) }
                GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0) }

            }
        }

        CompatLinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(0, height)
            end: Qt.point(0, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(0,0,0) }
                GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0) }
            }
        }
    }

    Rectangle {
        id: handle

        color: root.color
        x: (root.color.hsvSaturation) * root.width
        y: (root.color.hsvValue * root.height) - root.height
        width: 16
        height: 16
        radius: 8
        border.width: 2
        border.color: "#FFFFFF"
        transform: Translate { x: -handle.width / 2; y: -handle.height / 2 }

        function updatePosition() {
            x = (color.hsvSaturation) * root.width
            y = root.height - (color.hsvValue * root.height)
        }
        onColorChanged: updatePosition()

        onVisibleChanged: updatePosition()
    }

    MouseArea {
        id: mouseArea
        x: handle.width
        y: handle.height
        width: parent.width
        height: parent.height
        hoverEnabled: pressed
        transform: Translate { x: -handle.width; y: -handle.height }
        onPressed: {
            updateHandleColor()
        }

        onMouseXChanged: {
            updateHandleColor()
        }

        onMouseYChanged:  {
            updateHandleColor()
        }

        onPositionChanged: {
            updateHandleColor()
        }
    }

    onColorChanged: handle.color = root.color

    function updateHandleColor() {
        handle.color = Qt.hsva(root.color.  hsvHue, mouseArea.mouseX / width, 1.0 - (mouseArea.mouseY / height))
    }
}
