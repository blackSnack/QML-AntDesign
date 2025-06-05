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
    // Size of Avatar
    readonly property int containerSize: 32
    // Size of large Avatar
    readonly property int containerSizeLG: 40
    // Size of small Avatar
    readonly property int containerSizeSM: 24
    // Border color of avatars in a group
    readonly property color groupBorderColor: "#ffffff"
    // Overlapping of avatars in a group
    readonly property int groupOverlapping: -8
    // Spacing between avatars in a group
    readonly property int groupSpace: 4
    // Font size of Avatar
    readonly property int textFontSize: 18
    // Font size of large Avatar
    readonly property int textFontSizeLG: 24
    // Font size of small Avatar
    readonly property int textFontSizeSM: 14

    property color backgroundColor: AntTheme.colorTextPlaceholder
    property color color: AntTheme.colorTextLightSolid
}
