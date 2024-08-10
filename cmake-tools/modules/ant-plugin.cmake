set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
find_package(ant-qt COMPONENTS Core REQUIRED)

if (NOT TARGET ant-plugins)
    add_custom_target(ant-plugins)
endif()

function(add_ant_qml_plugin)    
    #parse args PLUGIN_NAME SOURCES are required args
    cmake_parse_arguments("ARG" "" "PLUGIN_NAME;LIB_NAME" "SOURCES;QT_COMPONENTS;LIBS" ${ARGN})

    if (NOT ARG_PLUGIN_NAME)
        message(FATAL_ERROR "PLUGIN_NAME is required")
    endif()
    if (NOT ARG_SOURCES)
        message(FATAL_ERROR "SOURCE is required")
    endif()
    if (NOT ARG_LIB_NAME)
        set(ARG_LIB_NAME ${ARG_PLUGIN_NAME})
    endif()

    if (NOT ARG_LIBS)
        set(ARG_LIBS "")
    endif()

    # default Qt quick deps
    list(APPEND ARG_QT_COMPONENTS Core Quick QuickControls2)

    # set plugin dir
    set(plugins_dir "${CMAKE_BINARY_DIR}/plugins")

    # set lib name
    set(library_name ${ARG_LIB_NAME})
    # set plugin name
    set(plugin_name ${ARG_PLUGIN_NAME})
    # set plugin output dir
    set(plugin_binary_dir "$<1:${plugins_dir}/${plugin_name}>")

    add_library(${library_name} MODULE ${ARG_SOURCES})

    # set lib output dir
    set_target_properties(${library_name} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${plugin_binary_dir}")

    # set deps
    set(target_deps "")
    foreach(dep ${ARG_QT_COMPONENTS})
        list(APPEND target_deps "Qt::${dep}")
    endforeach(dep ${ARG_QT_COMPONENTS})

    foreach(dep ${ARG_LIBS})
        list(APPEND target_deps ${dep})
    endforeach(dep ${ARG_LIBS})
    

    find_package(ant-qt COMPONENTS ${ARG_QT_COMPONENTS} REQUIRED)
    
    target_link_libraries(${library_name} PRIVATE ${target_deps})

    add_dependencies(ant-plugins ${library_name})

    set(plugin_qmldir_source "${CMAKE_CURRENT_SOURCE_DIR}/qmldir")
    set(plugin_qmldir_target "${plugin_binary_dir}/qmldir")
    add_custom_command(
        OUTPUT "${plugin_qmldir_target}"
        COMMAND ${CMAKE_COMMAND} -E copy "${plugin_qmldir_source}" "${plugin_qmldir_target}"
        DEPENDS "${plugin_qmldir_source}"
    )
    
    add_custom_target(${plugin_name}_gen_qmldir ALL 
        DEPENDS "${plugin_qmldir_target}"
    )

    add_dependencies(ant-plugins ${plugin_name}_gen_qmldir)

    include(GNUInstallDirs)
    install(DIRECTORY ${plugin_binary_dir}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/qml
    )

endfunction(add_ant_qml_plugin)


function(add_shaders)
    #parse args TARGET SOURCES are required args
    cmake_parse_arguments("ARG" "" "TARGET" "SOURCES;PREFIX" ${ARGN})

    if (NOT ARG_TARGET)
        message(FATAL_ERROR "PLUGIN_NAME is required")
    endif()
    if (NOT ARG_SOURCES)
        message(FATAL_ERROR "SOURCE is required")
    endif()

    if (NOT ARG_PREFIX)
        set(ARG_PREFIX "")
    endif()

    set(target ${ARG_TARGET})
    set(sources ${ARG_SOURCES})
    set(prefix ${ARG_PREFIX})
    
    find_package(ant-qt COMPONENTS ShaderTools REQUIRED)

    if (${QtX} STREQUAL "Qt6")
        qt6_add_shaders(${target}
            BATCHABLE
            PRECOMPILE
            OPTIMIZED
            PREFIX
                ${prefix}
            FILES
                ${sources}
        )
    else()
        message(FATAL_ERROR "Qt version is less than 6!" ${QtX})
    endif()
endfunction()


function(add_ant_test_app)
    #parse args PLUGIN_NAME SOURCES are required args
    cmake_parse_arguments("ARG" "" "EXE_NAME" "SOURCES;QT_COMPONENTS" ${ARGN})

    if (NOT ARG_EXE_NAME)
        message(FATAL_ERROR "EXE_NAME is required")
    endif()
    if (NOT ARG_SOURCES)
        message(FATAL_ERROR "SOURCE is required")
    endif()
 
    # default Qt quick deps
    list(APPEND ARG_QT_COMPONENTS Core Quick)

    set(test_app_target ${ARG_EXE_NAME})
    add_executable(${test_app_target} ${ARG_SOURCES})
    message("target: " ${test_app_target} " Source: " ${ARG_SOURCES})

     # set deps
    set(target_deps "")
    foreach(dep ${ARG_QT_COMPONENTS})
        list(APPEND target_deps "Qt::${dep}")
    endforeach(dep ${ARG_QT_COMPONENTS})
    find_package(ant-qt COMPONENTS ${ARG_QT_COMPONENTS} REQUIRED)
    
    target_link_libraries(${test_app_target} PRIVATE ${target_deps})     

    set_target_properties(${test_app_target} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "$<1:${CMAKE_BINARY_DIR}>/unittests")

    include(GNUInstallDirs)
    install(
        TARGETS
             ${test_app_target}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endfunction(add_ant_test_app)

