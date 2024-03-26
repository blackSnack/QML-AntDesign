var hueStep = 2; // 色相阶梯
var saturationStep = 0.16; // 饱和度阶梯，浅色部分
var saturationStep2 = 0.05; // 饱和度阶梯，深色部分
var brightnessStep1 = 0.05; // 亮度阶梯，浅色部分
var brightnessStep2 = 0.15; // 亮度阶梯，深色部分
var lightColorCount = 5; // 浅色数量，主色上
var darkColorCount = 4; // 深色数量，主色下
// 暗色主题颜色映射关系表
var darkColorMap = [{
                        index: 7,
                        opacity: 0.15
                    }, {
                        index: 6,
                        opacity: 0.25
                    }, {
                        index: 5,
                        opacity: 0.3
                    }, {
                        index: 5,
                        opacity: 0.45
                    }, {
                        index: 5,
                        opacity: 0.65
                    }, {
                        index: 5,
                        opacity: 0.85
                    }, {
                        index: 4,
                        opacity: 0.9
                    }, {
                        index: 3,
                        opacity: 0.95
                    }, {
                        index: 2,
                        opacity: 0.97
                    }, {
                        index: 1,
                        opacity: 0.98
                    }];
// Wrapper function ported from TinyColor.prototype.toHsv
// Keep it here because of `hsv.h * 360`
function toHsv(_ref) {
    var r = _ref.r,
    g = _ref.g,
    b = _ref.b;
    var hsv = rgbToHsv(r, g, b);
    return {
        h: hsv.h * 360,
        s: hsv.s,
        v: hsv.v
    };
}
function inputToQColor(color) {
    var red = parseInt(color.substring(1, 3), 16) / 255
    var green = parseInt(color.substring(3, 5), 16) / 255
    var blue = parseInt(color.substring(5, 7), 16) / 255

    return Qt.rgba(red, green, blue, 1)
}

function hsvToQColor(color) {
    return Qt.hsva(color.h / 360, color.s, color.v, 1)
}

function inputToRGB(color) {
    return {
        ok: true,
        formate: false,
        r: Math.round(color.r * 255),
        g: Math.round(color.g * 255),
        b: Math.round(color.b * 255),
        a: color.a
    }
}

function rgbToHex(r, g, b, allow3Char) {
    const hex = [
                  ("0" + Math.round(r).toString(16).toUpperCase()).slice(-2),
                  ("0" + Math.round(g).toString(16).toUpperCase()).slice(-2),
                  ("0" + Math.round(b).toString(16).toUpperCase()).slice(-2),
              ];

    // Return a 3 character hex if possible
    if (
            allow3Char &&
            hex[0].startsWith(hex[0].charAt(1)) &&
            hex[1].startsWith(hex[1].charAt(1)) &&
            hex[2].startsWith(hex[2].charAt(1))
            ) {
        return hex[0].charAt(0) + hex[1].charAt(0) + hex[2].charAt(0);
    }

    return hex.join('');
}

function rgbToHsv(r, g, b) {
    const color = Qt.rgba(r / 255, g / 255, b / 255, 255)
    return {
        h: color.hsvHue,
        s: color.hsvSaturation,
        v: color.hsvValue
    }
}

// Wrapper function ported from TinyColor.prototype.toHexString
// Keep it here because of the prefix `#`
function toHex(_ref2) {
    var r = _ref2.r,
    g = _ref2.g,
    b = _ref2.b;
    return "#".concat(rgbToHex(r, g, b, false));
}

// Wrapper function ported from TinyColor.prototype.mix, not treeshakable.
// Amount in range [0, 1]
// Assume color1 & color2 has no alpha, since the following src code did so.
function mix(rgb1, rgb2, amount) {
    var p = amount / 100;
    var rgb = {
        r: (rgb2.r - rgb1.r) * p + rgb1.r,
        g: (rgb2.g - rgb1.g) * p + rgb1.g,
        b: (rgb2.b - rgb1.b) * p + rgb1.b
    };
    return rgb;
}
function getHue(hsv, i, light) {
    var hue;
    // 根据色相不同，色相转向不同
    if (Math.round(hsv.h) >= 60 && Math.round(hsv.h) <= 240) {
        hue = light ? Math.round(hsv.h) - hueStep * i : Math.round(hsv.h) + hueStep * i;
    } else {
        hue = light ? Math.round(hsv.h) + hueStep * i : Math.round(hsv.h) - hueStep * i;
    }
    if (hue < 0) {
        hue += 360;
    } else if (hue >= 360) {
        hue -= 360;
    }
    return hue;
}
function getSaturation(hsv, i, light) {
    // grey color don't change saturation
    if (hsv.h === 0 && hsv.s === 0) {
        return hsv.s;
    }
    var saturation;
    if (light) {
        saturation = hsv.s - saturationStep * i;
    } else if (i === darkColorCount) {
        saturation = hsv.s + saturationStep;
    } else {
        saturation = hsv.s + saturationStep2 * i;
    }
    // 边界值修正
    if (saturation > 1) {
        saturation = 1;
    }
    // 第一格的 s 限制在 0.06-0.1 之间
    if (light && i === lightColorCount && saturation > 0.1) {
        saturation = 0.1;
    }
    if (saturation < 0.06) {
        saturation = 0.06;
    }
    return Number(saturation.toFixed(2));
}
function getValue(hsv, i, light) {
    var value;
    if (light) {
        value = hsv.v + brightnessStep1 * i;
    } else {
        value = hsv.v - brightnessStep2 * i;
    }
    if (value > 1) {
        value = 1;
    }
    return Number(value.toFixed(2));
}

function generate(color) {
    var opts = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
    var patterns = [];
    color = inputToQColor(color)
    var pColor = inputToRGB(color);
    for (var i = lightColorCount; i > 0; i -= 1) {
        var hsv = toHsv(pColor);
        var colorString = hsvToQColor({
                                          h: getHue(hsv, i, true),
                                          s: getSaturation(hsv, i, true),
                                          v: getValue(hsv, i, true)
                                      });
        patterns.push(colorString);
    }

    patterns.push(color);
    for (var _i = 1; _i <= darkColorCount; _i += 1) {
        var _hsv = toHsv(pColor);
        var _colorString = hsvToQColor({
                                           h: getHue(_hsv, _i),
                                           s: getSaturation(_hsv, _i),
                                           v: getValue(_hsv, _i)
                                       });

        patterns.push(_colorString);
    }

    // dark theme patterns
    if (opts.theme === 'dark') {
        return darkColorMap.map(function (_ref3) {
            var index = _ref3.index,
            opacity = _ref3.opacity;
            var darkColorString = toHex(mix(inputToRGB(inputToQColor(opts.backgroundColor || '#141414')), inputToRGB(patterns[index]), opacity * 100));
            return darkColorString;
        });
    }
    return patterns;
}
