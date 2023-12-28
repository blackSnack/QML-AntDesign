import QtQuick 2.15

import AntCore 1.0

DefaultStyle {
    bgStateColor: StateColor {
        normal: AntColors.transparent
        disabled: AntColors.transparent
        checked: normal
        pressed: AntTheme.colorBgTextActive
        hover: AntButtonStyleToken.textHoverBg
    }
    fontStateColor: StateColor {
        normal: AntTheme.colorText
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: normal
        hover: normal
    }

    hasGhost: false
    defaultStyle.borderStyle.width: 0
    smallStyle.borderStyle.width: 0
    largeStyle.borderStyle.width: 0
}
