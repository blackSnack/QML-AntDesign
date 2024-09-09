cmake_minimum_required(VERSION 3.15)

project(AntCore
    VERSION 1.0.0
    LANGUAGES CXX
)

find_package(ant-cmake-tools)

include(ant-plugin)

add_ant_qml_plugin(
    PLUGIN_NAME
        AntCore
    SOURCES
        Rectangle/AntRectangle.cpp
        Rectangle/AntRectangle.hpp
        Rectangle/BorderConfig.cpp
        Rectangle/BorderConfig.hpp
        Awesome/AntAwesomeUtils.cpp
        Awesome/AntAwesomeUtils.hpp
        LazyItemProxy/LazyItemProxy.hpp
        Enums/AntAwesome.hpp
        Enums/AntEnums.hpp
        Ant.hpp
        AntCorePlugin.cpp
        AntCorePlugin.qrc
)

add_shaders(
    TARGET
        AntCore
    SOURCES
        "Shadow/Shaders/shadow.frag"
        "Shadow/Shaders/blur.frag"
    )

target_include_directories(AntCore
        PUBLIC
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
                $<INSTALL_INTERFACE:include>
)

# add test application
add_ant_test_app(
    EXE_NAME    
        ${PROJECT_NAME}_TestApplication
    SOURCES
        TestApplication/main.cpp
        TestApplication/qml.qrc
)
