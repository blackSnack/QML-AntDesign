function getColor() {
    return "#FF0000"
}

class ControlColorStyle {
    constructor(enableColor, disableColor, pressedColor, checkedColor, hoverColor, focusColor) {
        this.enableColor = enableColor
        this.disableColor = disableColor
        this.pressedColor = pressedColor
        this.checkedColor = checkedColor
        this.hoverColor = hoverColor
        this.focusColor = focusColor
     }
}
function getControlColor(control, colorStyle)
{
    if (!control) {
        return colorStyle.disableColor
    }

    return !control.enabled ? colorStyle.disableColor : (control.checked ? colorStyle.checkedColor : (control.pressed ? colorStyle.pressedColor : (control.hovered ? colorStyle.hoverColor : (control.focus ? colorStyle.focusColor : colorStyle.enableColor))))
}
