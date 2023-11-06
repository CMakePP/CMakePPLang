# Get CMakeTest and add it to our module path
include(FetchContent)

FetchContent_Declare(
    cmaize
    GIT_REPOSITORY https://github.com/CMakePP/CMaize
)

set(build_testing_old "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(cmaize)
include(cmaize/cmaize)


FetchContent_Declare(
    cmake_test
    GIT_REPOSITORY https://github.com/CMakePP/CMakeTest
    GIT_TAG v0.1.8
)
set(build_testing_old "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(cmake_test)
include(cmake_test/cmake_test)

set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)


ct_add_dir(algorithm)
ct_add_dir(asserts)
ct_add_dir(class)
ct_add_dir(docs)
ct_add_dir(examples)
ct_add_dir(exceptions)
ct_add_dir(map)
ct_add_dir(object)
ct_add_dir(serialization)
ct_add_dir(types)
ct_add_dir(utilities)


# Stress tests can take a long time to run
#ct_add_dir(stress_tests)
