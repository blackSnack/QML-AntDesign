cmake_minimum_required(VERSION 3.15)

project(ant-qml-components
    VERSION 1.0.0
    LANGUAGES CXX
)

add_subdirectory(Core)
add_subdirectory(Icon)
add_subdirectory(Button)
add_subdirectory(Tooltip)
add_subdirectory(Badge)
add_subdirectory(Text)
add_subdirectory(Mask)
add_subdirectory(Spin)
add_subdirectory(QRCode)
add_subdirectory(Checkbox)
add_subdirectory(Popover)
add_subdirectory(Menu)
add_subdirectory(Dropdown)
add_subdirectory(Slider)
add_subdirectory(ColorPicker)
add_subdirectory(Input)
add_subdirectory(InputNumber)
add_subdirectory(Divider)
add_subdirectory(Ribbon)

# set QML plugin import dir
set(QML_IMPORT_PATH "${QML_IMPORT_PATH};${CMAKE_BINARY_DIR}/plugins" CACHE STRING "" FORCE)
