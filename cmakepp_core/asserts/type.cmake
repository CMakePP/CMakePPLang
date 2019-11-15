include_guard()
include(cmakepp_core/types/get_type)
include(cmakepp_core/utilities/are_equal)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Tests that the arguments are of the correct types.
#
# This function loops over an indefinite amount of (type, value)-pairs ensuring
# that the values are of the correct types. This typically occurs as part of
# type-checking a function's signature. If a value is not of the correct type an
# error is raised. These type-checks only occur if CMakePP is in debug mode.
#
# :param ARGV: The types and values of the arguments to check. ``ARGV`` should
#              consist of (type, value) pairs and an error will be raised if
#              there is an odd number of arguments provided.
# :type ARGV: list(str)
# :var CMAKEPP_CORE_DEBUG_MODE: If enabled then the type-checks will occur.
# :type CMAKEPP_CORE_DEBUG_MODE: bool
#
# Example Usage:
# ==============
#
# The following code snippet shows how to use ``cpp_assert_type`` to assert
# that your function was called with the correct types. In this case we assume
# that the positional arguments to the function are a description, an integer,
# and a boolean.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    function(my_fxn arg0 arg1 arg2)
#        cpp_assert_type(desc "${arg0}" int "${arg1}" bool "${arg2}")
#    endfunction()
#]]
function(cpp_assert_type)
    cpp_enable_if_debug()
    math(EXPR _cat_is_odd "${ARGC} % 2")
    if(${_cat_is_odd})
        message(
                FATAL_ERROR
                "cpp_assert_type takes an even number of arguments."
                "cpp_assert_type was called with: [${ARV}]"
        )
    endif()

    # Range can't handle [0, -1] by 2's, *i.e.*, don't do anything
    if(${ARGC} EQUAL 0)
        return()
    endif()

    # Range is inclusive despite arguments starting at 0...
    math(EXPR _cat_last "${ARGC} - 1")

    foreach(_cat_pair_i RANGE 0 ${_cat_last} 2)
        math(EXPR _cat_pair_j "${_cat_pair_i} + 1")
        set(_cat_type "${ARGV${_cat_pair_i}}")
        set(_cat_value "${ARGV${_cat_pair_j}}")
        cpp_get_type(_cat_result "${_cat_value}")
        cpp_are_equal(_cat_result "${_cat_result}" "${_cat_type}")
        cpp_assert(${_cat_result} "${_cat_value} is ${_cat_type}")
    endforeach()
endfunction()
