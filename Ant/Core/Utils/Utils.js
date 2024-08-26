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

class Rect {
    constructor(qrect) {
        this.rect = qrect
    }
    get width() { return this.rect.width }
    get hfWidth() { return this.rect.width / 2 }
    get height() { return this.rect.height }
    get hfHeight() { return this.rect.height / 2 }
    get x() { return this.rect.x }
    get y() { return this.rect.y }
    get topMid() { return { x: this.rect.x + this.rect.width / 2, y: this.rect.y } }
    get centre() { return { x: this.rect.x + this.rect.width / 2, y: this.rect.y + this.height / 2 } }
    get leftTop() { return { x: this.rect.x, y: this.rect.y } }
    get leftBottom() { return { x: this.rect.x, y: this.rect.y + this.rect.height } }
    get rightTop() { return { x: this.rect.x + this.rect.width, y: this.rect.y } }
    get rightBottom() { return { x: this.rect.x + this.rect.width, y: this.rect.y + this.rect.height } }

    contains(rect) {
        var tempRect = new Rect(rect)
        return this.x <= tempRect.x && this.y <= tempRect.y && this.rightTop.x >= tempRect.rightTop.x && this.rightBottom.y >= tempRect.rightBottom.y
    }
}

function rotatePoint(cx, cy, x, y, angle) {
    var radians = angle * Math.PI / 180;
    var cosTheta = Math.cos(radians);
    var sinTheta = Math.sin(radians);
    var tx = -cx + x;
    var ty = -cy + y;

    var xNew = tx * cosTheta - ty * sinTheta;
    var yNew = tx * sinTheta + ty * cosTheta;

    return { x: xNew + cx, y: yNew + cy };
}

// centre translate
function translatePoint(x, y, dx, dy) {
    const offsetX = x - dx
    const offsetY = y - dy
    return { x: x - offsetX, y: y - offsetY };
}

// centre translate
function translateRect(rect, x, y) {
    const result = translatePoint(rect.centre.x, rect.centre.y, x, y)
    return new Rect(Qt.rect(result.x - rect.hfWidth, result.y - rect.hfHeight, rect.width, rect.height))
}

function getRoot(item) {
    return item.parent ? getRoot(item.parent) : item
}

function getControlColor(control, colorStyle) {
    if (!control) {
        return colorStyle.disableColor
    }

    return !control.enabled ? colorStyle.disableColor : (control.checked ? colorStyle.checkedColor : (control.pressed ? colorStyle.pressedColor : (control.hovered ? colorStyle.hoverColor : (control.focus ? colorStyle.focusColor : colorStyle.enableColor))))
}

function getItem(key, label, icon, children, type) {
    return {
        key,
        label,
        icon,
        children,
        type
    }
}

function pixels(length, font) {
    if (length.endsWith("em")) {
        return Number.parseFloat(length.slice(0, -2)) * font.pixelSize
    }

    return Number.parseFloat(length)
}

function tryFetchValue(value, defaultValue)
{
    return value === undefined ? defaultValue : value
}
