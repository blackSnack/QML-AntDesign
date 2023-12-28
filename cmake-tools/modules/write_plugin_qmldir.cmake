function(write_plugin_qmldir)
    #parse args PLUGIN_NAME SOURCES are required args
    cmake_parse_arguments("ARG" "" "PLUGIN_NAME;TARGET_DIR" ${ARGN})

    if (NOT ARG_PLUGIN_NAME)
         message(FATAL_ERROR "PLUGIN_NAME is required")
    endif()
    if (NOT ARG_TARGET_DIR)
         message(FATAL_ERROR "TARGET_DIR is required")
    endif()

    file(WRITE ${TARGET_DIR}
        "module ${ARG_PLUGIN_NAME}\n"
        "plugin ${ARG_PLUGIN_NAME}\n"
    )
endfunction()