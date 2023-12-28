import QtQuick 2.15

import AntCore 1.0

DefaultStyle {
    borderStateColor: StateColor {
        normal: AntTheme.colorPrimary
        disabled: AntButtonStyleToken.borderColorDisabled
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    borderGhostStateColor: borderStateColor

    bgStateColor: StateColor {
        normal: AntTheme.colorPrimary
        disabled: AntTheme.colorBgContainerDisabled
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    bgDangerStateColor: StateColor {
        normal: AntTheme.colorError
        disabled: AntTheme.colorBgContainerDisabled
        checked: normal
        pressed: AntTheme.colorErrorActive
        hover: AntTheme.colorErrorHover
    }

    fontStateColor: StateColor {
        normal: AntButtonStyleToken.primaryColor
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: AntTheme.colorTextLightSolid
        hover: AntTheme.colorTextLightSolid
    }

    fontDangerStateColor: StateColor {
        normal: AntButtonStyleToken.dangerColor
        disabled: AntColors.textDisabledColor
        checked: normal
        pressed: AntTheme.colorTextLightSolid
        hover: AntTheme.colorTextLightSolid
    }

    fontGhostStateColor: borderGhostStateColor
    fontDangerGhostStateColor: borderDangerStateColor
}
