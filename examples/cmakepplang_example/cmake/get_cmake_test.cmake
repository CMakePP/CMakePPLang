include_guard()

#[[
# This function encapsulates the process of getting CMakeTest using CMake's
# FetchContent module. We have encapsulated it in a function so we can set
# the options for its configure step without affecting the options for the
# parent project's configure step (namely we do not want to build CMakeTest's
# unit tests).
#]]
function(get_cmake_test)
    # Store whether we are building tests or not, then turn off the tests
    set(build_testing_old "${BUILD_TESTING}")
    set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

    # Download CMakeTest and bring it into scope
    include(FetchContent)
    FetchContent_Declare(
        cmake_test
        GIT_REPOSITORY https://github.com/CMakePP/CMakeTest
    )
    FetchContent_MakeAvailable(cmake_test)

    set(
        CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${cmake_test_SOURCE_DIR}/cmake"
        PARENT_SCOPE
    )

    # Restore the previous value
    set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)
endfunction()

# Call the function we just wrote to get CMakeTest
get_cmake_test()

# Include CMakeTest
include(cmake_test/cmake_test)
