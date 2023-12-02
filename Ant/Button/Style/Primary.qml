import QtQuick 2.15

import Ant.Core 1.0

import "./private"

Default {
    borderStateColor: StateColor {
        normal: AntColors.blue_6
        disabled: AntColors.gray_5
        checked: AntColors.blue_5
        pressed: AntColors.blue_7
        hover: AntColors.blue_5
    }

    bgStateColor:  StateColor {
        normal: AntColors.blue_6
        disabled: AntColors.gray_5
        checked: AntColors.blue_6
        pressed: AntColors.blue_7
        hover: AntColors.blue_5
    }

    fontStateColor: StateColor {
        normal: AntColors.gray_1
        disabled: AntColors.textDisabledColor
        checked: AntColors.gray_1
        pressed: AntColors.gray_1
        hover: AntColors.gray_1
    }
}
