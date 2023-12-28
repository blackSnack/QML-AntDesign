import QtQuick 2.15

import AntCore 1.0

DefaultStyle {
    bgStateColor: StateColor {
        normal: AntColors.transparent
        disabled: AntColors.transparent
        checked: AntColors.transparent
        pressed: AntColors.transparent
        hover: AntColors.transparent
    }
    fontStateColor: StateColor {
        normal: AntTheme.colorPrimary
        disabled: AntTheme.colorTextDisabled
        checked: normal
        pressed: AntTheme.colorPrimaryActive
        hover: AntTheme.colorPrimaryHover
    }

    hasGhost: false
    defaultStyle.borderStyle.width: 0
    smallStyle.borderStyle.width: 0
    largeStyle.borderStyle.width: 0
}
