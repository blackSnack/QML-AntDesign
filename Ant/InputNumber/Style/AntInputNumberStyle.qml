import QtQuick 2.15

import AntCore 1.0
import AntInput 1.0

// Base on AntInputStyle
AntInputStyle {
    // 面性变体操作按钮背景色
    property color filledHandleBg: AntColors.gray_4
    // 操作按钮激活背景色
    property color handleActiveBg: AntColors.gray_13_A2
    // 	操作按钮背景色
    property color handleBg: AntColors.gray_1
    // 操作按钮悬浮颜色
    property color handleHoverColor: AntColors.blue_6
    // 操作按钮边框颜色
    property color handleBorderColor: AntColors.gray_5
    // 操作按钮图标颜色
    property color handleColor: AntColors.gray_13_A45

    property int handleFontSize: 7

    property var handleVisible: "auto" // true | "auto"

    property int handleWidth: 22

    
}
