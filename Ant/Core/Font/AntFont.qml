pragma Singleton

import QtQuick 2.15

QtObject {
    readonly property int size12: 12
    readonly property int size14: 14
    readonly property int size16: 16

    readonly property string fontFamily: "SF Pro Text"

    readonly property var fontLineHeight: function (fontConfig){
        return fontConfig.pixelSize + 8;
    }
    property font testFont: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: "Ya Hei",
                                        pixelSize: size12,
                                        weight: Font.Normal,
                                    })

    property font reuglar12: Qt.font({
                                         bold: false,
                                         underline: false,
                                         family: fontFamily,
                                         pixelSize: size12,
                                         weight: Font.Normal,
                                     })
    property font medium12: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: fontFamily,
                                        pixelSize: size12,
                                        weight: Font.Medium
                                    })
    property font semibold12: Qt.font({
                                          bold: false,
                                          underline: false,
                                          family: fontFamily,
                                          pixelSize: size12,
                                          weight: Font.DemiBold
                                      })

    property font reuglar14: Qt.font({
                                         bold: false,
                                         underline: false,
                                         family: fontFamily,
                                         pixelSize: size14,
                                         weight: Font.Normal
                                     })
    property font medium14: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: fontFamily,
                                        pixelSize: size14,
                                        weight: Font.Medium
                                    })
    property font semibold14: Qt.font({
                                          bold: false,
                                          underline: false,
                                          family: fontFamily,
                                          pixelSize: size14,
                                          weight: Font.DemiBold
                                      })
    property font reuglar16: Qt.font({
                                         bold: false,
                                         underline: false,
                                         family: fontFamily,
                                         pixelSize: size16,
                                         weight: Font.Normal
                                     })
    property font medium16: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: fontFamily,
                                        pixelSize: size16,
                                        weight: Font.Medium
                                    })
    property font semibold16: Qt.font({
                                          bold: false,
                                          underline: false,
                                          family: fontFamily,
                                          pixelSize: size16,
                                          weight: Font.DemiBold
                                      })
}
