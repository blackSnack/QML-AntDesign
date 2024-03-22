function colorFromat(color, format) {
    if (format === "rgb") {
        return colorToRGB(color)
    } else if (format === "hsv") {
        return colorToHsv(color)
    } else if (format === "hex") {
        return `${color}`
    }
}

function colorToRGB(color) {
    return `rgb(${Math.round(color.r * 255)}, ${Math.round(color.g * 255)}, ${Math.round(color.b * 255)})`
}

function colorToHsv(color) {
    const numberHandle = function(value){
        return Number(value).toLocaleString(Qt.locale(), 'f', 0)
    }
    return `hsv(${numberHandle(color.hsvHue * 360)}, ${numberHandle(color.hsvSaturation * 100)}%, ${numberHandle(color.hsvValue * 100)}%)`
}
