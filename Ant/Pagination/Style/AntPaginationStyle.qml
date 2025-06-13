// MIT License
// Copyright (c) 2025 Karl
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

    ///< Background color of active Pagination item	string
    property color itemActiveBg: AntTheme.colorBgContainer
    ///< Background color of disabled active Pagination item
    property color itemActiveBgDisabled: AntTheme.colorBgTextActive
    ///< Text color of disabled active Pagination item
    property color itemActiveColorDisabled: AntTheme.colorTextDisabled
    ///< Background color of Pagination item
    property color itemBg: AntTheme.colorBgContainer
    ///< Background color of input
    property color itemInputBg: AntTheme.colorBgContainer
    ///< Background color of Pagination item link
    property color itemLinkBg: AntTheme.colorBgContainer
    ///< Size of Pagination item
    property int itemSize: 32
    ///< Size of small Pagination item	number
    property int itemSizeSM: 24
    ///< Top of Pagination size changer	number
    property int miniOptionsSizeChangerTop: 0
}
