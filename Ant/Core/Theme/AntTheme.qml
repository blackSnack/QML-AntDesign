pragma Singleton

import QtQuick 2.15

import "."

QtObject {
    property int controlHeight: 32

    property int controlHeightLG: 40

    property int controlHeightSM: 24

    property int lineType: Qt.SolidLine

    property int lineWidthFocus: 4

    property int lineWidth: 1

    property int borderRadius: 6

    property int borderRadiusLG: 8

    property int borderRadiusSM: 4

    property int paddingContentHorizontal: 16

    property int paddingXS: 8

    property color colorBgContainer: AntColors.gray_1

    property color colorBgContainerDisabled: AntColors.gray_13_A4

    property color colorBgTextActive: AntColors.gray_13_A15

    property color colorBorder: AntColors.gray_5

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
}
