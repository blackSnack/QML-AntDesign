pragma Singleton

import QtQuick 2.15

import "."

QtObject {
    property int controlHeight: 32

    property int controlHeightLG: 40

    property int controlHeightSM: 24

    property int controlInteractiveSize: 16

    property int lineType: Qt.SolidLine

    property int lineWidthFocus: 4

    property int lineWidth: 1

    property real lineHeight: 1.5714285714285714

    property int borderRadius: 6

    property int borderRadiusLG: 8

    property int borderRadiusSM: 4

    property int borderRadiusXS: 2

    property int paddingContentHorizontal: 16

    property int paddingXS: 8

    property int paddingSM: 12

    property int margin: 16

    property int marginXS: 8

    property int zIndexPopupBase: 1000

    property size sizePopupArrow: Qt.size(16, 8)

    property font defaultFont: AntFont.reuglar14

    property font defaultFontLG: AntFont.reuglar16

    property font fontWeightStrong: AntFont.semibold14

    property color colorBgElevated: AntColors.gray_1

    property color colorBgContainer: AntColors.gray_1

    property color colorTextHeading: AntColors.gray_13_A88

    property color colorBgContainerDisabled: AntColors.gray_13_A4

    property color colorBgTextActive: AntColors.gray_13_A15

    property color colorBorder: AntColors.gray_5

    property color colorSuccess: AntColors.green_6

    property color colorSuccessText: AntColors.green_6

    property color colorError: AntColors.red_5

    property color colorErrorActive: AntColors.errorActiveColor

    property color colorErrorBg: AntColors.red_1

    property color colorErrorBorderHover: AntColors.red_3

    property color colorErrorHover: AntColors.red_4

    property color colorLink: AntColors.blue_6

    property color colorLinkActive: AntColors.blue_7

    property color colorLinkHover: AntColors.blue_4

    property color colorPrimary: AntColors.blue_6

    property color colorPrimaryActive: AntColors.blue_7

    property color colorPrimaryBorder: AntColors.blue_3

    property color colorPrimaryHover: AntColors.blue_5

    property color colorText: AntColors.gray_13_A88

    property color colorTextLightSolid: AntColors.gray_1

    property color colorTextDisabled: AntColors.gray_13_A25

    property color colorBgSpotlight: AntColors.gray_13_A85

    property color colorTextPlaceholder: AntColors.gray_13_A25

    property color colorWarning: AntColors.gold_6

    property color colorWarningBorderHover: AntColors.gold_4

    property color colorSplit: AntColors.gray_13_A6

    property color colorBgMask: AntColors.gray_13_A45
}
