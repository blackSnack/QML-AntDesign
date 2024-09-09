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
    property int size: Ant.Middle

    // Font size of option
    property int optionFontSize: 14
    
    // Height of option
    property int optionHeight: 32

    // z-index of dropdown
    property int zIndexPopup: 1050

    // Font weight when option is selected
    property int optionSelectedFontWeight: 600

    // Text color when option is selected
    property color optionSelectedColor: AntColors.gray_13_A88 

    // Background color when option is selected
    property color optionSelectedBg: AntColors.palettes.blue_1

    // Background color of selector
    property color selectorBg: AntColors.gray_1

    // Background color when option is active
    property color optionActiveBg: AntColors.gray_13_A4
}
