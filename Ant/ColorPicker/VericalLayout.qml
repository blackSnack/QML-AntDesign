import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt5Compat.GraphicalEffects

import AntSlider 1.0
import AntCore 1.0
import AntDropdown 1.0
import AntButton 1.0
import AntTooltip 1.0
import AntText 1.0
import AntIcon 1.0
import AntInput 1.0
import AntInputNumber 1.0
import "qrc:/AntCore/Utils/Utils.js" as AntCoreUtils

MouseArea {
    id: root

    required property color defaultValue
    readonly property color currentColor: colorBg.currentColor

    hoverEnabled: true
    implicitHeight: content.height
    implicitWidth:  d.implicitWidth

    QtObject {
        id: d

        property color defaultValue: root.defaultValue
        readonly property int implicitWidth: 256
        readonly property int spacing: 12
        readonly property int sliderVSpacing: 8
        readonly property int alphaBgWidth: 28
        readonly property int alphaBgSquareSize: 7
        readonly property int dropdownAreaSpacing: 2
        readonly property int colorInfoSpacing: 4
        readonly property int dropdownWidth: 60
        readonly property int alphaInputNumberWidth: 60
        readonly property int inpuNumberLeftPadding: 4
        readonly property int inpuNumberRightPadding: 0
        readonly property int inpuFontSize: 12

        function colorBgColor() {
            return Qt.hsva(paletteSlider.value / paletteSlider.max, d.defaultValue.hsvSaturation, d.defaultValue.hsvValue, d.defaultValue.a)
        }

        function alphaSliderValue() {
            return d.defaultValue.a * alphaSlider.max
        }

        onDefaultValueChanged: {
            paletteSlider.value = Math.max(d.defaultValue.hsvHue, 0) * paletteSlider.max
            colorBg.color = colorBgColor()
        }
    }

    Column {
        id: content
        width: parent.width
        spacing: d.spacing

        AntColorBackground {
            id: colorBg
            width: parent.width
            color: d.defaultValue

            Connections {
                target: colorBg

                function onCurrentColorChanged() {
                    if(d.defaultValue !== colorBg.currentColor) {
                        d.defaultValue = colorBg.currentColor
                    }
                }
            }

            Connections {
                target: paletteSlider

                function onValueChanged() {
                    colorBg.color = d.colorBgColor()
                }
            }
        }

        Row {
            width: parent.width
            spacing: d.spacing - paletteSlider.handleSize / 2
            Column {
                width: parent.width - alphaBg.width - parent.spacing
                spacing: d.sliderVSpacing
                Layout.fillWidth: true
                AntPaletteSlider {
                    id: paletteSlider
                    width: parent.width
                }

                AntAlphaSlider {
                    id: alphaSlider
                    width: parent.width
                    color: colorBg.currentColor
                    value: d.alphaSliderValue()

                    onValueChanged: {
                        alphaInputNumber.value = value
                        d.defaultValue.a = alphaSlider.value / alphaSlider.max
                    }

                    Connections {
                        target: alphaInputNumber

                        function onValueChanged() {
                            alphaSlider.value = alphaInputNumber.value
                        }
                    }
                }
            }

            AntTransparentBg {
                id: alphaBg
                width: d.alphaBgWidth
                height: width
                radius: AntTheme.borderRadiusSM
                border.color: AntTheme.colorSplit
                border.width: AntTheme.lineWidth
                squareSize: d.alphaBgSquareSize
                color: Qt.hsva(colorBg.currentColor.hsvHue,
                               colorBg.currentColor.hsvSaturation,
                               colorBg.currentColor.hsvValue,
                               alphaSlider.value / alphaSlider.max)
            }
        }

        Row {
            spacing: d.colorInfoSpacing
            MouseArea {
                id: triggerArea

                y: (parent.height - height) / 2.0
                width: c.width
                height: c.height
                Row {
                    id: c
                    spacing: d.dropdownAreaSpacing
                    AntText {
                        color: formatDropdown.visible ? AntTheme.colorTextDisabled : AntTheme.colorText
                        text: formatDropdown.currentSelectedText.length !== 0 ? formatDropdown.currentSelectedText[0] : ""
                        font: AntFont.reuglar12
                    }

                    AntIcon {
                        source: "DownOutlined"
                    }
                }

                AntDropdown {
                    id: formatDropdown
                    target: triggerArea
                    placement: Ant.BottomLeft
                    trigger: Ant.Click
                    z: 1070
                    control.width: d.dropdownWidth
                    currentSelectedKey: ["HEX"]
                    menu: [
                        AntCoreUtils.getItem("HEX", "HEX", "", [], "Item"),
                        AntCoreUtils.getItem("HSV", "HSV", "", [], "Item"),
                        AntCoreUtils.getItem("RGB", "RGB", "", [], "Item"),
                    ]

                    Connections {
                        target: formatDropdown.menuItem

                        function onClick() {
                            formatDropdown.close()
                        }
                    }
                }
            }

            Loader {
                y: (parent.height - height) / 2
                sourceComponent: {
                    switch(formatDropdown.currentSelectedKey[0]) {
                    case "HEX":
                        return hexComp
                    case "HSV":
                        return hsvComp
                    case "RGB":
                        return rgbComp
                    }
                }
            }

            SmallInputNumberWithPerSuffix {
                id: alphaInputNumber
                width: d.alphaInputNumberWidth
                min: 0
                max: 100
                value: alphaSlider.value
            }
        }
    }

    function hexToQmlColor(hex, alpha) {
        var red = parseInt(hex.substring(0, 2), 16) / 255
        var green = parseInt(hex.substring(2, 4), 16) / 255
        var blue = parseInt(hex.substring(4, 6), 16) / 255
        return Qt.rgba(red, green, blue, alpha)
    }

    function colorToHex(color) {
        var red = Math.round(color.r * 255).toString(16).toUpperCase()
        var green = Math.round(color.g * 255).toString(16).toUpperCase()
        var blue = Math.round(color.b * 255).toString(16).toUpperCase()
        return `${red}${green}${blue}`
    }

    component SmallInputNumber: AntInputNumber {
        antStyle {
            size: Ant.Small
            leftPadding: d.inpuNumberLeftPadding
            rightPadding: d.inpuNumberRightPadding
            inputFontSizeSM: d.inpuFontSize
        }
    }

    component SmallInputNumberWithPerSuffix: SmallInputNumber {
        formatter: (value)=>{ return Number(value).toLocaleString(Qt.locale(), 'f', precision) + "%" }
        parser: (text)=>{
                    return Number.fromLocaleString(Qt.locale(), text.replace("%", ''))
                }
    }

    Component {
        id: hexComp

        AntInput {
            id: hexInput
            width: 148
            prefix: "#"
            antStyle {
                size: Ant.Small
                prefixColor: AntColors.gray_13_A25
                inputFontSizeSM: d.inpuFontSize
            }
            validator: RegularExpressionValidator  { regularExpression: /^[0-9A-Fa-f]{0,6}$/ }
            text: colorToHex(colorBg.currentColor)
            onTextChanged: {
                if (text.length == 6 && text !== colorToHex(root.currentColor)) {
                    d.defaultValue = hexToQmlColor(text, alphaSlider.value / alphaSlider.max)
                }
            }
        }
    }

    Component {
        id: hsvComp

        Row {
            spacing: 4
            SmallInputNumber {
                id: hueInputNumber
                width: 46
                min: 0
                max: 360
                value: root.currentColor.hsvHue * max

                onStep: (value, info) => {
                            d.defaultValue.hsvHue = value / max
                        }
            }

            SmallInputNumberWithPerSuffix {
                id: hsvS
                width: 46
                min: 0
                max: 100
                value: root.currentColor.hsvSaturation * max
                onStep: (value, info)=> {
                            d.defaultValue.hsvSaturation = value / max
                        }
            }
            SmallInputNumberWithPerSuffix {
                width: 46
                min: 0
                max: 100
                value: root.currentColor.hsvValue * max
                onStep: (value, info)=> {
                            d.defaultValue.hsvValue = value / max
                        }
            }
        }
    }

    Component {
        id: rgbComp

        Row {
            spacing: 4
            SmallInputNumber {
                width: 46
                min: 0
                max: 255
                value: Math.round(root.currentColor.r * max)
                onStep: (value, info)=> {
                            d.defaultValue.r = value / max
                        }
            }

            SmallInputNumber {
                width: 46
                min: 0
                max: 255
                value: Math.round(root.currentColor.g * max)
                onStep: (value, info)=> {
                            d.defaultValue.g = value / max
                        }
            }

            SmallInputNumber {
                width: 46
                min: 0
                max: 255
                value: Math.round(root.currentColor.b * max)
                onStep: (value, info)=> {
                            d.defaultValue.b = value / max
                        }
            }
        }
    }
}
