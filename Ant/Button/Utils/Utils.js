.pragma library
.import Ant.Button.Style 1.0 as Style

function bindStyleStateColor(button, style) {
    let config = style.stateColor
    if (!button) {
        return config.normal
    }
    return !button.enabled ? config.disabled : (button.checked ? config.checked : (button.pressed ? config.pressed : (button.hovered ? config.hover : config.normal)))
}

function fetchTargetStyle(sizeType, style) {
    switch(sizeType)
    {
    case Style.AntButtonStyle.SizeType.Default:
        return style.defaultStyle
    case Style.AntButtonStyle.SizeType.Large:
        return style.largeStyle
    case Style.AntButtonStyle.SizeType.Small:
        return style.smallStyle
    default:
        return style.defaultStyle
    }
}
