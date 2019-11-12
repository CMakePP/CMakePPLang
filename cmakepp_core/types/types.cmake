include_guard()
include(cmakepp_core/types/bool)
include(cmakepp_core/types/filepath)
include(cmakepp_core/types/float)
include(cmakepp_core/types/integer)
include(cmakepp_core/types/list)
include(cmakepp_core/types/string)
include(cmakepp_core/types/target)

## Convience list of recognized intrinsic CMake types. Useful for looping.
set(CMAKEPP_CMAKE_TYPES bool filepath float int list str target)

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
# is, for example, a string.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    set(a_variable "hello world")
#    cpp_is_type(result str "${a_variable}")
#    message("Variable is a string: ${result}")  # Prints "TRUE"
#]]
function(cpp_is_type _cit_result _cit_type _cit_str2check)
    string(TOLOWER "${_cit_type}" _cit_type)
    if("${_cit_type}" STREQUAL "bool")
        cpp_is_bool("${_cit_result}" "${_cit_str2check}")
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
    elseif("${_cit_type}" STREQUAL "str")
        set(${_cit_result} TRUE)  #It's not anything else...
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
# is, for example, not a string.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    set(a_variable "hello world")
#    cpp_is_not_type(result str "${a_variable}")
#    message("Variable is not a string: ${result}")  # Prints "FALSE"
#]]
function(cpp_is_not_type _cint_result _cint_type _cint_str2check)
    cpp_is_type("${_cint_result}" "${_cint_type}" "${_cint_str2check}")
    cpp_negate("${_cint_result}" "${${_cint_result}}")
    cpp_return("${_cint_result}")
endfunction()

#[[[ Asserts the provided string can be lexically cast to the provided type.
#
# This function will raise an error if the provided string can not be lexically
# casted to the provided type. The type-check is done only if CMakePP is in
# debug mode.
#
# :param _cat_type: The type to lexically cast to. Must be a recognized type. If
#                   ``_cat_type`` is not a recognized type then an error will be
#                   raised.
# :type _cat_type: str
# :param _cat_str2check: The string which should be lexically castable to an
#                        instance of type ``_cat_type``.
# :type _cat_str2check: str
# :var CMAKEPP_CORE_DEBUG_MODE: If set to TRUE CMakePP is in debug mode and the
#                               type-check will occur.
#
# Example Usage:
# ==============
#
# This example shows how to assert that the contents of a variable are, for
# example, a string. In practice, such a check is usually done first thing
# within a user-defined function where the type is not so obvious.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/types)
#    set(a_var "Hello World")
#    cpp_assert_type(str "${a_var}")
#
#]]
function(cpp_assert_type _cat_type _cat_str2check)
    cpp_enable_if_debug()
    cpp_is_type(_cat_result "${_cat_type}" "${_cat_str2check}")
    cpp_assert(_cat_result "'${_cat_str2check}' is a ${_cat_type}")
endfunction()
