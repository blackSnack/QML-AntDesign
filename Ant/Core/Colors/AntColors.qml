pragma Singleton

import QtQuick 2.15

QtObject {
    // gray
    readonly property color gray_1: "#ffffff"
    readonly property color gray_5: "#d9d9d9"
    readonly property color gray_13: "#000000"
    readonly property color gray_13_A0: "#00000000"
    readonly property color gray_13_A4: "#04000000"
    readonly property color gray_13_A6: "#0F000000"
    readonly property color gray_13_A15: "#26000000"
    readonly property color gray_13_A25: "#40000000"
    readonly property color gray_13_A40: "#0A000000"
    readonly property color gray_13_A85: "#D9000000"
    readonly property color gray_13_A88: "#E0000000"

    // blue
    readonly property color blue_3: "#91caff"
    readonly property color blue_4: "#69b1ff"
    readonly property color blue_5: "#4096ff"
    readonly property color blue_6: "#1677ff"
    readonly property color blue_7: "#0958d9"

    // red
    readonly property color red_1: "#fff1f0"
    readonly property color red_3: "#ffa39e"
    readonly property color red_4: "#ff7875"
    readonly property color red_5: "#ff4d4f"

    readonly property color errorActiveColor: "#d9363e"

    // transparent
    readonly property color transparent: "transparent"

    // font color
    readonly property color texHeadingColor: gray_13_A88
    readonly property color textDisabledColor: gray_13_A25
}
