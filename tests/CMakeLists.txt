# Get CMakeTest and add it to our module path
include(FetchContent)

FetchContent_Declare(
    cpp
    GIT_REPOSITORY https://github.com/CMakePP/CMaize
)

set(build_testing_old "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(cpp)
include(cpp/cpp)


FetchContent_Declare(
    cmake_test
    GIT_REPOSITORY https://github.com/CMakePP/CMakeTest
)
set(build_testing_old "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(cmake_test)
include(cmake_test/cmake_test)

set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)

# Define a function to make it easier to add tests to CTest
function(add_cmake_unit_tests prefix)
    string(REGEX REPLACE ";" "\\\;" test_path "${CMAKE_MODULE_PATH}")
    foreach(testi ${ARGN})
        set(full_path ${CMAKE_CURRENT_LIST_DIR}/${testi}.cmake)
        add_test(
                NAME "${prefix}:${testi}"
                COMMAND ${CMAKE_COMMAND}
                -DCMAKE_MODULE_PATH=${test_path} -P ${full_path}
        )
    endforeach()
endfunction()

ct_add_dir(algorithm)
ct_add_dir(asserts)
ct_add_dir(class)
ct_add_dir(examples)
ct_add_dir(exceptions)
ct_add_dir(map)
ct_add_dir(object)
ct_add_dir(serialization)
ct_add_dir(types)
ct_add_dir(utilities)


# Stress tests can take a long time to run
ct_add_dir(stress_tests)
