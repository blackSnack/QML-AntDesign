﻿# AntDesign

#### Introduce
QML component library based on AntDesign

#### CI Build Status

| [Window][win-link] |
| ------------------ |
| ![win-badge]       |

[win-link]: https://github.com/blackSnack/QML-AntDesign/actions?query=windows-qt6-vs2019 "Windows Action"
[win-badge]: https://github.com/blackSnack/QML-AntDesign/workflows/windows-qt6-vs2019/badge.svg

#### How to build
##### Required environment
* Qt >= 6.0
* Python >= 3.0
* CMake >= 3.15
* Conan [1.59, 2.0)

##### Install & Config Conan
```
    pip install conan==1.6.0
    conan config init
```

##### Build
* Make sure the required packages is installed and add the path to environment.
* Clone the code into a folder
* Sync submodule for kms-conan
```
    git submodule update --init
```
* Config project with the CMakeLists.txt
* Run `ant-plugins` target to build all `Ant*Plugin.dll` to plugins folder

#### Components
* [AntButton](https://gitee.com/antenna_1/ant-design/wikis/AntButton)
* [AntBadge](https://gitee.com/antenna_1/ant-design/wikis/AntBage)
* [AntQRCode](https://gitee.com/antenna_1/ant-design/wikis/AntQRCode)
* [AntCheckBox](https://gitee.com/antenna_1/ant-design/wikis/AntCheckbox)
* [AntSpin](https://gitee.com/antenna_1/ant-design/wikis/AntSpin)
* [AntTooltip](https://gitee.com/antenna_1/ant-design/wikis/AntTooltip)
* [AntPopover](https://gitee.com/antenna_1/ant-design/wikis/AntPopover)
* [AntMenu](https://gitee.com/antenna_1/ant-design/wikis/AntMenu)
* [AntDropdown](https://gitee.com/antenna_1/ant-design/wikis/AntDropdown)
* [AntColorPick](https://gitee.com/antenna_1/ant-design/wikis/AntColorPick)
* [AntInput](https://gitee.com/antenna_1/ant-design/wikis/AntInput)
* [AntInputNumber](https://gitee.com/antenna_1/ant-design/wikis/AntInputNumber)
* [AntMask]()
* [AntDivider](https://gitee.com/antenna_1/ant-design/wikis/AntDivider)
* [AntRibbon](https://gitee.com/antenna_1/ant-design/wikis/AntRibbon)
* [AntSlider](https://gitee.com/antenna_1/ant-design/wikis/AntSlider)