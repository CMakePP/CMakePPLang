include_guard()
include(cmakepp_core/types/bool)
include(cmakepp_core/types/description)
include(cmakepp_core/types/empty_string)
include(cmakepp_core/types/filepath)
include(cmakepp_core/types/float)
include(cmakepp_core/types/integer)
include(cmakepp_core/types/list)
include(cmakepp_core/types/target)

#[[[ Checks if a string can be lexically cast to a specified type.
#
# This function allows checking if a string is lexically castable to a specified
# type. Ultimately this function simply dispatches to the appropriate
# ``cpp_is_<type>`` function based on ``_cit_type``. It should be noted that a
# string is type ``str`` if it is not any other type (that is to say ``str`` is
# the fallback type for a value).
#
# :param _cit_result: Identifier to hold the result.
# :type _cit_result: identifier
# :param _cit_type: The type to attempt to lexical cast ``_cit_str2check`` to.
#                   Must be a recognized intrinsic CMake type. An error will be
#                   raised if ``_cit_type`` is not a recognized type.
# :type _cit_type: str
# :param _cit_str2check: The string we want to know the type of.
# :returns: ``TRUE`` if ``_cit_str2check`` is of type ``_cit_type`` and
#           ``FALSE`` otherwise. Results are returned via ``_cit_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following snippet shows how to check if the value an identifier contains
# is, for example, a description.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    set(a_variable "hello world")
#    cpp_is_type(result desc "${a_variable}")
#    message("Variable is a description: ${result}")  # Prints "TRUE"
#]]
function(cpp_is_type _cit_result _cit_type _cit_str2check)
    string(TOLOWER "${_cit_type}" _cit_type)
    if("${_cit_type}" STREQUAL "bool")
        cpp_is_bool("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "desc")
        cpp_is_description("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "filepath")
        cpp_is_absolute_filepath("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "float")
        cpp_is_float("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "int")
        cpp_is_int("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "list")
        cpp_is_list("${_cit_result}" "${_cit_str2check}")
    elseif("${_cit_type}" STREQUAL "target")
        cpp_is_target("${_cit_result}" "${_cit_str2check}")
    else()
        message(
            FATAL_ERROR
            "${_cit_type} is not a recognized CMake type. "
            "Recognized CMake types include: [${CMAKEPP_CMAKE_TYPES}].")
    endif()
    cpp_return("${_cit_result}")
endfunction()

#[[[ Checks if a string cannot be lexically cast to the specified type.
#
# This function allows checking if a string is unable to be lexically cast to a
# specified type. This function is a convenience wrapper for negating the
# results of ``cpp_is_type``.
#
# :param _cint_result: Identifier to hold the result.
# :type _cint_result: identifier
# :param _cint_type: The type to attempt to lexical cast ``_cint_str2check`` to.
#                    Must be a recognized intrinsic CMake type. An error will be
#                    raised if ``_cint_type`` is not a recognized type.
# :type _cint_type: str
# :param _cint_str2check: The string we want to know the type of.
# :returns: ``FALSE`` if ``_cint_str2check`` is of type ``_cint_type`` and
#           ``TRUE`` otherwise. Results are returned via ``_cint_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following snippet shows how to check if the value an identifier contains
# is, for example, not a description.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    set(a_variable "hello world")
#    cpp_is_not_type(result desc "${a_variable}")
#    message("Variable is not a description: ${result}")  # Prints "FALSE"
#]]
function(cpp_is_not_type _cint_result _cint_type _cint_str2check)
    cpp_is_type("${_cint_result}" "${_cint_type}" "${_cint_str2check}")
    cpp_negate("${_cint_result}" "${${_cint_result}}")
    cpp_return("${_cint_result}")
endfunction()

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
        cpp_is_type(_cat_result "${_cat_type}" "${_cat_value}")
        message("${_cat_result} ${_cat_type} ${_cat_value}")
        cpp_assert(${_cat_result} "${_cat_value} is ${_cat_type}")
    endforeach()
endfunction()

