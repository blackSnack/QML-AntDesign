import QtQuick 2.15

import Ant.Core 1.0
import Ant.Button.Utils 1.0
import "./private"
import "."

ButtonStyle {
    property int borderLineStyle: Qt.SolidLine
    property StateColor borderStateColor: StateColor {
        normal: AntColors.gray_5
        disabled: AntColors.gray_5
        checked: AntColors.blue_5
        pressed: AntColors.blue_7
        hover: AntColors.blue_5
    }

    property StateColor bgStateColor: StateColor {
        normal: AntColors.gray_1
        disabled: AntColors.gray_5
        checked: AntColors.gray_1
        pressed: AntColors.gray_1
        hover: AntColors.gray_1
    }

    property StateColor fontStateColor: StateColor {
        normal: AntColors.texHeadingColor
        disabled: AntColors.textDisabledColor
        checked: normal
        pressed: AntColors.blue_7
        hover: AntColors.blue_5
    }

    defaultStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            width: 1
            radius: 6
            lineStyle: borderLineStyle
        }
        bgStyle: ButtonBackgroundStyle {
            stateColor: bgStateColor
        }
        fontStyle: ButtonFontStyle {
            stateColor: fontStateColor
            font: AntFont.reuglar14
            lineHeight: AntFont.fontLineHeight(AntFont.reuglar14)
        }
        compSize: Qt.size(74, 32)
    }

    smallStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            width: 1
            radius: 4
            lineStyle: borderLineStyle
        }
        bgStyle: defaultStyle.bgStyle
        fontStyle: defaultStyle.fontStyle
        compSize: Qt.size(58, 24)
    }


    largeStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            width: 1
            radius: 8
            lineStyle: borderLineStyle
        }
        bgStyle: defaultStyle.bgStyle
        fontStyle: ButtonFontStyle {
            stateColor: fontStateColor
            font: AntFont.reuglar16
            lineHeight: AntFont.fontLineHeight(AntFont.reuglar16)
        }
        compSize: Qt.size(81, 40)
    }
}
