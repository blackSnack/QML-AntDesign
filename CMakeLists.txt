cmake_minimum_required(VERSION 3.16)

project(AntDesignn VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick QuickControls2)

set(CMAKE_AUTORCC ON)
set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/Ant ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)
qt_standard_project_setup()

qt_add_executable(appAntDesignn
    main.cpp
    Ant/Ant.qrc
)

qt_add_qml_module(appAntDesignn
    URI AntDesignn
    VERSION 1.0
    QML_FILES Main.qml
    SOURCES AntRectangle.hpp AntRectangle.cpp
    SOURCES BorderConfig.hpp BorderConfig.cpp
    SOURCES QmlUtil.hpp
)

set_target_properties(appAntDesignn PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAntDesignn
    PRIVATE
        Qt6::Quick
        Qt6::QuickControls2
)

install(TARGETS appAntDesignn
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
