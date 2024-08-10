cmake_minimum_required(VERSION 3.16)

project(AntDesign VERSION 0.1 LANGUAGES CXX)

if(NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE EQUAL "")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(KMS_DEPS "kms-qrcode_generator")
set(BUILD_KMS_MODULES "")
set(CMAKE_CXX_STANDARD 17)

add_subdirectory(cmake-tools)

if (NOT TARGET kms-tools)
    add_subdirectory(kms)
endif()

add_subdirectory(Ant)
