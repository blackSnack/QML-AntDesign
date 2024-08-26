import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import AntCore 1.0

Item {
    Text {
        id: theItem
        x: 100
        y: 100
        // anchors.fill: parent
        width: 140
        height: 140
        font.pixelSize: 118
        color: AntColors.blue_5
        text: "hello shader"
    }
    //! [source]
    ShaderEffectSource {
        id: theSource
        sourceItem: theItem
    }
    ShaderEffect {
        id: effect
        x: theItem.x
        y: theItem.y
        width: theItem.width
        height: theItem.height
        property variant source: theSource
        property variant shadow: ShaderEffectSource {
            sourceItem: ShaderEffect {
                width: theItem.width
                height: theItem.height
                property variant delta: Qt.size(0.0, 1.0 / height)
                property variant source: ShaderEffectSource {
                    sourceItem: ShaderEffect {
                        width: theItem.width
                        height: theItem.height
                        property variant delta: Qt.size(1.0 / width, 0.0)
                        property variant source: theSource
                        fragmentShader: "Shadow/Shaders/blur.frag.qsb"
                    }
                }
                fragmentShader: "Shadow/Shaders/blur.frag.qsb"
            }
        }
        property real angle
        property variant offset: Qt.point(15.0 * Math.cos(angle), 15.0 * Math.sin(angle))
        NumberAnimation on angle { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 6000 }
        property variant delta: Qt.size(offset.x / width, offset.y / height)
        property real darkness: shadowSlider.value
        fragmentShader: "Shadow/Shaders/shadow.frag.qsb"
        Slider {
            id: shadowSlider
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 4
            anchors.rightMargin: 4
            height: 40
        }
        // GaussianBlur {
        //     x: theItem.x
        //     y: theItem.y
        //     width: theItem.width
        //     height: theItem.height
        //     source: effect
        //     radius: 200
        //     samples: 400
        // }
    }
}
