cmake_minimum_required(VERSION 3.15)

project(ant-test-application
        VERSION 0.1.0
        LANGUAGES CXX)
set(NAMESPACE "ant")

find_package(ant-cmake-tools)
find_package(ant-qt COMPONENTS Core Gui Quick REQUIRED)

add_library(test-application
        src/AntTestApplication.cpp
        include/ant/AntTestApplication.hpp
)

add_library(${NAMESPACE}::test-application ALIAS test-application)
set_target_properties(test-application PROPERTIES OUTPUT_NAME "ant-test-application")

target_include_directories(test-application
        PUBLIC
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                $<INSTALL_INTERFACE:include>
        PRIVATE
                src
)

target_link_libraries(test-application
    PUBLIC
        Qt::Core
        Qt::Gui
        Qt::Quick
)

include(GNUInstallDirs)

# install library
install(
        TARGETS
            test-application
        EXPORT ${PROJECT_NAME}-targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# install include directory
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)


include(kms-export)

export_targets(
        PACKAGE_NAME ${PROJECT_NAME}
        PACKAGE_VERSION ${PROJECT_VERSION}
        EXPORT ${PROJECT_NAME}-targets
        NAMESPACE ${NAMESPACE}
)
