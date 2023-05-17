include_guard()

#[[
# This function encapsulates the process of getting CMakePPLang using CMake's
# FetchContent module. We have encapsulated it in a function so we can set
# the options for its configure step without affecting the options for the
# parent project's configure step (namely we do not want to build CMakePPLang's
# unit tests).
#]]
function(get_cmakepp_lang)

    # Store whether we are building tests or not, then turn off the tests
    set(build_testing_old "${BUILD_TESTING}")
    set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

    # Download CMakePPLang and bring it into scope
    include(FetchContent)
    FetchContent_Declare(
        cmakepp_lang
        GIT_REPOSITORY https://github.com/CMakePP/CMakePPLang
    )
    FetchContent_MakeAvailable(cmakepp_lang)

    set(
        CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${cmakepp_lang_SOURCE_DIR}/cmake"
        PARENT_SCOPE
    )

    # Restore the previous value
    set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)
endfunction()

# Call the function we just wrote to get CMakePPLang
get_cmakepp_lang()

# Include CMakePPLang
include(cmakepp_lang/cmakepp_lang)
