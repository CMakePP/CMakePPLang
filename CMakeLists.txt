cmake_minimum_required(VERSION 3.14) # b/c of FetchContent_MakeAvailable
project(CMakePPCore VERSION 1.0.0)

option(BUILD_TESTS "Should we build and run the unit tests?" TRUE)
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
