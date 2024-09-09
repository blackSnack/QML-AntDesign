// MIT License
// Copyright (c) 2024 Karl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
import QtQuick 2.15

import AntCore 1.0

QtObject {
    id: root

    property int itemHeight: 40

    property int itemPaddingInline: 16

    property int iconSize: 14

    property color itemColor: AntTheme.colorTextHeading

    // Hover color of menu item text
    property color itemHoverColor: AntTheme.colorTextHeading

    property color itemDisabledColor: AntTheme.colorTextDisabled

    // Color of selected menu item text
    property color itemSelectedColor: AntColors.blue_6

    property color itemActiveBg: AntColors.blue_1

    property color itemSelectedBg: AntColors.blue_1

    property color itemBg: AntColors.gray_1

    property color itemHoverBg: AntColors.gray_13_A6

    property color subMenuItemBg: AntColors.gray_13_A2

    property color groupTitleColor: AntColors.gray_13_A45

    property int groupTitleFontSize: 14

    property int itemBorderRadius: 8

    property int itemMarginBlock: 4

    property int itemMarginInline: 4

    property int iconMarginInlineEnd: 10
}