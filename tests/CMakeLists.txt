# Get CMakeTest and add it to our module path
include(FetchContent)
FetchContent_Declare(
    cmake_test
    GIT_REPOSITORY https://github.com/CMakePP/CMakeTest
    GIT_TAG install
)
set(BUILD_TESTS OFF)
FetchContent_MakeAvailable(cmake_test)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR} "${cmake_test_SOURCE_DIR}")

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

add_subdirectory(array)
add_subdirectory(asserts)
add_subdirectory(class)
add_subdirectory(examples)
add_subdirectory(iteration)
add_subdirectory(logic)
add_subdirectory(map)
add_subdirectory(serialization)
add_subdirectory(timer)
add_subdirectory(types)
add_subdirectory(utilities)

# Stress tests can take a long time to run
#add_subdirectory(stress_tests)
