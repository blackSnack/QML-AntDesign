import QtQuick 2.15

import AntCore 1.0

ButtonStyle {
    property int borderLineStyle: Qt.SolidLine
    property StateColor borderStateColor: StateColor {
        normal: AntButtonStyleToken.defaultBorderColor
        disabled: AntButtonStyleToken.borderColorDisabled
        checked: AntTheme.colorPrimaryHover
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    property StateColor borderDangerStateColor: StateColor {
        normal: AntTheme.colorError
        disabled: AntButtonStyleToken.borderColorDisabled
        checked: normal
        pressed: AntTheme.colorErrorBorderHover
        hover: AntTheme.colorErrorBorderHover
    }

    property StateColor borderGhostStateColor: StateColor {
        normal: AntButtonStyleToken.defaultGhostBorderColor
        disabled: AntTheme.colorBorder
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    property StateColor bgStateColor: StateColor {
        normal: AntButtonStyleToken.defaultBg
        disabled: AntTheme.colorBgContainerDisabled
        checked: normal
        pressed: AntButtonStyleToken.defaultBg
        hover: AntButtonStyleToken.defaultBg
    }

    property StateColor bgDangerStateColor: bgStateColor

    property StateColor bgGhostStateColor: StateColor {
        normal: AntButtonStyleToken.ghostBg
        disabled: normal
        checked: normal
        pressed: normal
        hover: normal
    }

    property StateColor fontStateColor: StateColor {
        normal: AntButtonStyleToken.defaultColor
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    property StateColor fontDangerStateColor: StateColor {
        normal: AntTheme.colorError
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: AntTheme.colorErrorActive
        hover: AntTheme.colorErrorHover
    }

    property StateColor fontGhostStateColor: StateColor {
        normal: AntButtonStyleToken.defaultGhostColor
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    property StateColor fontDangerGhostStateColor: fontDangerStateColor

    hasGhost: true

    defaultStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            dangerStateColor: borderDangerStateColor
            ghostStateColor: borderGhostStateColor
            dangerGhostStateColor: dangerStateColor
            width: AntTheme.lineWidth
            radius: AntTheme.borderRadius
            roundRadius: defaultStyle.compSize.height
            lineStyle: borderLineStyle
        }

        bgStyle: ButtonBackgroundStyle {
            stateColor: bgStateColor
            dangerStateColor: bgDangerStateColor
            ghostStateColor: bgGhostStateColor
            dangerGhostStateColor: ghostStateColor
        }
        fontStyle: ButtonFontStyle {
            stateColor: fontStateColor
            dangerStateColor: fontDangerStateColor
            ghostStateColor: fontGhostStateColor
            dangerGhostStateColor: fontDangerGhostStateColor
            font: AntButtonStyleToken.textFont
            lineHeight: AntFont.fontLineHeight(AntButtonStyleToken.textFont)
        }
        spacing: AntButtonStyleToken.spacing
        paddingInline: AntButtonStyleToken.paddingInline
        compSize: Qt.size(74, 32)
        compOnlyIconSize: Qt.size(32, 32)
        onlyIconSize: AntButtonStyleToken.onlyIconSize
    }

    smallStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            dangerStateColor: borderDangerStateColor
            ghostStateColor: borderGhostStateColor
            dangerGhostStateColor: dangerStateColor
            width: AntTheme.lineWidth
            radius: AntTheme.borderRadiusSM
            roundRadius: smallStyle.compSize.height
            lineStyle: borderLineStyle
        }
        bgStyle: defaultStyle.bgStyle
        fontStyle: ButtonFontStyle {
            stateColor: fontStateColor
            dangerStateColor: fontDangerStateColor
            ghostStateColor: fontGhostStateColor
            dangerGhostStateColor: fontDangerGhostStateColor
            font: AntButtonStyleToken.textFontSM
            lineHeight: AntFont.fontLineHeight(AntButtonStyleToken.textFontSM)
        }
        spacing: AntButtonStyleToken.spacing
        paddingInline: AntButtonStyleToken.paddingInlineSM
        compSize: Qt.size(58, 24)
        compOnlyIconSize: Qt.size(24, 24)
        onlyIconSize: AntButtonStyleToken.onlyIconSizeSM
    }


    largeStyle: ButtonSizeStyle {
        borderStyle: ButtonBorderStyle {
            stateColor: borderStateColor
            dangerStateColor: borderDangerStateColor
            ghostStateColor: borderGhostStateColor
            dangerGhostStateColor: dangerStateColor
            width: AntTheme.lineWidth
            radius: AntTheme.borderRadiusLG
            roundRadius: largeStyle.compSize.height
            lineStyle: borderLineStyle
        }
        bgStyle: defaultStyle.bgStyle
        fontStyle: ButtonFontStyle {
            stateColor: fontStateColor
            dangerStateColor: fontDangerStateColor
            ghostStateColor: fontGhostStateColor
            dangerGhostStateColor: fontDangerGhostStateColor
            font: AntButtonStyleToken.textFontLG
            lineHeight: AntFont.fontLineHeight(AntButtonStyleToken.textFontLG)
        }
        spacing: AntButtonStyleToken.spacing
        paddingInline: AntButtonStyleToken.paddingInlineLG
        compSize: Qt.size(81, 40)
        compOnlyIconSize: Qt.size(40, 40)
        onlyIconSize: AntButtonStyleToken.onlyIconSizeLG
    }
}
