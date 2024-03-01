import QtQuick 2.15

import AntCore 1.0
QtObject {
    property string size: "middle" // large | middle | small
    // 激活态边框色
    property color activeBorderColor: AntTheme.colorPrimary
    // 悬浮态边框色
    property color hoverBorderColor: AntTheme.colorPrimaryHover
    // 输入框激活状态时背景颜色
    property color activeBg: AntTheme.colorBgContainer
    // 前/后置标签背景色
    property color addonBg: AntColors.gray_13_A2
    // 输入框hover状态时背景颜色
    property color hoverBg: AntTheme.colorBgContainer
    property color textColor: AntTheme.colorText
    property color prefixColor: AntTheme.colorText
    // 输入框横向内边距
    property int paddingInline: 11
    // 大号输入框横向内边距
    property int paddingInlineLG: 11
    // 小号输入框横向内边距
    property int paddingInlineSM: 7
    // 输入框纵向内边距
    property int paddingBlock: 4
    // 大号输入框纵向内边距
    property int paddingBlockLG: 7
    // 小号输入框纵向内边距
    property int paddingBlockSM: 0

    // font size
    property int inputFontSize: 14
    property int inputFontSizeLG: 16
    property int inputFontSizeSM: 14

}
