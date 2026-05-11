cmake_minimum_required(VERSION 3.22.1)
project("prootix")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_definitions(-DANDROID)
add_definitions(-D__ANDROID__)
add_definitions(-DANDROID_API=24)

add_compile_options(-Wall -Wextra -Werror -O2 -fPIC)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_library(prootix SHARED
    jni_bridge.cpp
    proot_manager.cpp
    terminal_native.cpp
)

target_link_libraries(prootix
    android
    log
    z
)

find_library(log-lib log)
find_library(android-lib android)
find_library(z-lib z)

target_link_libraries(prootix
    ${log-lib}
    ${android-lib}
    ${z-lib}
)