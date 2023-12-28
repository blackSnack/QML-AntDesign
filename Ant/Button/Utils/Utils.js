.pragma library
.import AntButton 1.0 as Style
function fetchStateColorConfig(button, style)
{
    if (button.ghost && button.style.hasGhost) {
        return button.danger ? style.dangerGhostStateColor : style.ghostStateColor
    }

    return button.danger ? style.dangerStateColor : style.stateColor
}

function bindStyleStateColor(button, style) {
    if(!button) return "#FFFFFF"

    let config = fetchStateColorConfig(button, style)
    return !button.enabled ? config.disabled : (button.checked ? config.checked : (button.pressed ? config.pressed : (button.hovered ? config.hover : config.normal)))
}

function bindCompSize(button, style) {
    if(!button) return Qt.size(0, 0)

    let config = button.iconOnly ? style.compOnlyIconSize : style.compSize

    if (!button.iconOnly) {
        const w = button.contentItem.contentWidth + button.leftPadding + button.rightPadding + button.implicitIndicatorWidth + button.spacing
        const contentW = config.width > w ? config.width : w
        const contentH = config.height
        return Qt.size(contentW, contentH)
    }
    return config//Qt.size(config.width + button.leftPadding + button.rightPadding, contentH)
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
