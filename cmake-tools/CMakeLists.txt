cmake_minimum_required(VERSION 3.15)

project(ant-cmake-tools
    VERSION 1.0.0
    LANGUAGES NONE
)

include(GNUInstallDirs)
set(INSTALL_CONFIG_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/modules
    DESTINATION ${INSTALL_CONFIG_DIR}
)

include(CMakePackageConfigHelpers)

# 1. generate version file
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

# 2. generate template config
# Make Ant cmake tools available when import project 
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-cmake.in
    "@PACKAGE_INIT@\n"
    "\n"
    "include(${CMAKE_CURRENT_LIST_DIR}/use_ant_cmake_tools.cmake)\n"
    "use_ant_cmake_tools()\n"
)
# 3. generate config
configure_package_config_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION ${INSTALL_CONFIG_DIR}
)

# 4. install
install(
    FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/use_ant_cmake_tools.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION ${INSTALL_CONFIG_DIR}
)

# 5. write config to be found whithin this same project
#    like find_package(ant-cmake-tools)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/as-subdirectory-stub/${PROJECT_NAME}/${PROJECT_NAME}-config.cmake
    "include(${CMAKE_CURRENT_LIST_DIR}/use_ant_cmake_tools.cmake)\n"
    "use_ant_cmake_tools()\n"
)

# 6. set project_DIR
set(${PROJECT_NAME}_DIR
    "${CMAKE_CURRENT_BINARY_DIR}/as-subdirectory-stub/${PROJECT_NAME}"
    CACHE INTERNAL "" FORCE
)

# Add ant-test-application to project
add_subdirectory(ant-test-application)
