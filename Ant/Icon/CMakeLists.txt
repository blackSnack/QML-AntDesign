cmake_minimum_required(VERSION 3.15)

project(AntIcon
    VERSION 1.0.0
    LANGUAGES CXX
)

find_package(ant-cmake-tools)

include(ant-plugin)

add_ant_qml_plugin(
    PLUGIN_NAME
        AntIcon
    SOURCES
        AntSvgReader.cpp
        AntSvgIcon.cpp
        AntIconPlugin.cpp
        AntIconPlugin.qrc
    QT_COMPONENTS
        Svg
)

# add test application
add_ant_test_app(
    EXE_NAME    
        ${PROJECT_NAME}_TestApplication
    SOURCES
        TestApplication/main.cpp
        TestApplication/qml.qrc
)