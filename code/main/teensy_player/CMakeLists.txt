# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(
    player
    VERSION 1.0
    DESCRIPTION "The code for the soccer player robot. https://github.com/mendelcollege-robotics/robotica"
    LANGUAGES C
)

#[===[
# Create a static library target named "my_lib"
add_library(my_lib
    STATIC
    src/my_lib.c
)
target_include_directories(
    my_lib
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Create an executable target with the same name as the project name
add_executable(
    ${PROJECT_NAME}
    src/main.c
)

# Link the library to the executable. PRIVATE means that the library is not
# exposed to targets that depend on this target.
target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE
    my_lib
)
]===]
target_sources(app PRIVATE src/main.c)
