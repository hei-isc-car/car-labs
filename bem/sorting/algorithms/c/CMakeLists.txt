cmake_minimum_required(VERSION 3.5)

project(bubbleSort LANGUAGES C)

add_executable(bubbleSort src/main.c src/fct.hpp)

install(TARGETS bubbleSort
    LIBRARY DESTINATION release/)

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

add_custom_command(TARGET bubbleSort 
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bubbleSort> ${CMAKE_SOURCE_DIR}/release)
