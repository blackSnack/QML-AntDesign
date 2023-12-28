cmake_minimum_required(VERSION 3.15)

project(ant-qml-components 
    VERSION 1.0.0
    LANGUAGES CXX
)

add_subdirectory(Core)
add_subdirectory(Icon)
add_subdirectory(Button)
add_subdirectory(Tooltip)

# set QML plugin import dir
set(QML_IMPORT_PATH "${QML_IMPORT_PATH};${CMAKE_BINARY_DIR}/plugins" CACHE STRING "" FORCE)
