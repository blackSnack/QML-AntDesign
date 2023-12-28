# load tools
function(use_ant_cmake_tools)
    list(APPEND CMAKE_MODULE_PATH ${ant_cmake_tools_modules_dir})
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} PARENT_SCOPE)
endfunction(use_ant_cmake_tools)

# cache module directory
set(ant_cmake_tools_modules_dir ${CMAKE_CURRENT_LIST_DIR}/modules CACHE INTERNAL "")

