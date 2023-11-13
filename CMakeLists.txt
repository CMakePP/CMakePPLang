cmake_minimum_required(VERSION 3.14) # b/c of FetchContent_MakeAvailable
project(CMakePPLang VERSION 1.0.0 LANGUAGES NONE)

# Testing defaults to OFF so project including CMakePPLang do not build
# its tests
option(BUILD_TESTING "Should we build and run the unit tests?" OFF)

# Adds CMakePPLang to the module path so it can be included as
# include(cmakepp_lang/cmakepp_lang), checks to make sure it hasn't been added
# before.
list(FIND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" path_has_cmake)
if(${path_has_cmake} STREQUAL "-1")
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
endif()
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" CACHE STRING "" FORCE)

if(NOT CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # For projects including CMakePPLang, add CMakePPLang to the module path
    # for ease of use
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
endif()

# Toggle to build tests for CMakeLists
if("${BUILD_TESTING}")
    include(CTest)
    add_subdirectory(tests)
endif()
