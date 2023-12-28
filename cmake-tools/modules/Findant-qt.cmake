if (NOT DEFINED CACHE{QT_DEFAULT_MAJOR_VERSION})
    if (NOT QT_DEFAULT_MAJOR_VERSION)
        message(STATUS "Define QT_DEFAULT_MAJOR_VERSION to 6")
        set(QT_DEFAULT_MAJOR_VERSION "6")
    endif()
    set(QT_DEFAULT_MAJOR_VERSION ${QT_DEFAULT_MAJOR_VERSION} CACHE INTERNAL "")
endif()

if (NOT DEFINED CACHE{QtX})
    set(QtX "Qt${QT_DEFAULT_MAJOR_VERSION}" CACHE INTERNAL "")
endif()

if(ant-qt_FIND_REQUIRED)
    set(ant-qt_FIND_REQUIRED_PARAM "REQUIRED")
endif()

if(ant-qt_FIND_QUIET)
    set(ant-qt_FIND_QUIET_PARAM "QUIET")
endif()

find_package(${QtX} COMPONENTS 
    ${ant-qt_FIND_COMPONENTS}
    ${ant-qt_FIND_REQUIRED_PARAM}
    ${ant-qt_FIND_QUIET_PARAM}
)

set(ant-qt_FOUND ${${QtX}_FOUND})
