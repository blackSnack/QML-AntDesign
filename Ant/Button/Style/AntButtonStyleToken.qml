pragma Singleton

import QtQuick 2.15

import AntCore 1.0

QtObject {
    property color primaryColor: AntColors.gray_1

    property color textHoverBg: AntColors.gray_13_A6

    property color borderColorDisabled: AntColors.gray_5

    property color dangerColor: AntColors.gray_1

    property color defaultBg: AntColors.gray_1

    property color defaultBorderColor: AntColors.gray_5

    property color defaultColor: AntColors.gray_13_A88

    property color defaultGhostBorderColor: AntColors.gray_1

    property color defaultGhostColor: AntColors.gray_1

    property color ghostBg: AntColors.transparent

    property color groupBorderColor: AntColors.blue_5

    property color linkHoverBg: AntColors.transparent

    property int onlyIconSize: 16

    property int onlyIconSizeLG: 18

    property int onlyIconSizeSM: 14

    property int fontWeight: Font.Normal

    property int contentFontSize: 14

    property int contentFontSizeLG: 16

    property int contentFontSizeSM: 14

    property int paddingInline: 15

    property int paddingInlineLG: 15

    property int paddingInlineSM: 7

    property int spacing: 8


    property font textFont: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: AntFont.fontFamily,
                                        pixelSize: contentFontSize,
                                        weight: fontWeight,
                                    })
    property font textFontLG: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: AntFont.fontFamily,
                                        pixelSize: contentFontSizeLG,
                                        weight: fontWeight,
                                    })
    property font textFontSM: Qt.font({
                                        bold: false,
                                        underline: false,
                                        family: AntFont.fontFamily,
                                        pixelSize: contentFontSizeSM,
                                        weight: fontWeight,
                                    })
}
