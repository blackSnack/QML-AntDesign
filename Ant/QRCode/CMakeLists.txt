cmake_minimum_required(VERSION 3.15)

project(AntQRCode 
    VERSION 1.0.0
    LANGUAGES CXX
)

find_package(ant-cmake-tools)
find_package(kms-cmake-tools REQUIRED)

include(kms-deps)

define_dependencies(
    PRIVATE
        kms-qrcode_generator
)

include(ant-plugin)

add_ant_qml_plugin(
    PLUGIN_NAME
        AntQRCode
    SOURCES
        AntQRCodeGen.cpp
        AntQRCodePlugin.cpp
        AntQRCodePlugin.qrc    
    LIBS
        kms::qrcode_generator
)

# add test application
add_ant_test_app(
    EXE_NAME    
        ${PROJECT_NAME}_TestApplication
    SOURCES
        TestApplication/main.cpp
        TestApplication/qml.qrc
)
