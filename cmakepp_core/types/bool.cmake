include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)

#[[[ Determines if the provided string can lexically be cast to a boolean.
#
# CMake recognizes the following (case-insensitive) strings as being boolean
# constants:
#
# - true values: ON, YES, TRUE, and Y
# - false values: OFF, NO, FALSE, N, and NOTFOUND
#
# Other strings, most notably ``"0"`` and ``"1"``, are capable of being used in
# CMake's if statements, but are arguably not boolean constants. Rather they are
# castable to booleans. For that reason, this function will not recognize them
# as being of type boolean.
#
# :param _cib_return: Identifier to hold the result.
# :param _cib_str2check: The string we are checking for bool-ness
# :type _cib_str2check: str
# :returns: ``TRUE`` if ``_cib_str2check`` is lexically castable to a boolean
#           and ``FALSE`` otherwise. The result is returned as ``_cib_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following code snippet shows how to use ``cpp_is_bool`` to determine if
# the provided variable is a boolean.

# .. code-block:: cmake
#
#    include(cmakepp_core/types/bool)
#    set(var2check TRUE)
#    cpp_is_bool(result ${var2check})
#    message("var2check is a bool: ${result}")
#
# The code snippet will print ``var2check is a bool: TRUE``.
#]]
function(cpp_is_bool _cib_return _cib_str2check)
    set(${_cib_return} FALSE)
    string(TOUPPER "${_cib_str2check}" _cib_str2check)
    foreach(_cib_bool_i ON YES TRUE Y OFF NO FALSE N NOTFOUND)
        if("${_cib_str2check}" STREQUAL "${_cib_bool_i}")
            set(${_cib_return} TRUE)
            break()
        endif()
    endforeach()
    cpp_return(${_cib_return})
endfunction()

#[[[ Determines if the provided string is not lexically castable to a boolean.
#
# CMake recognizes the following (case-insensitive) strings as being boolean
# constants:
#
# - true values: ON, YES, TRUE, and Y
# - false values: OFF, NO, FALSE, N, and NOTFOUND
#
# Other strings, most notably ``"0"`` and ``"1"``, are capable of being used in
# CMake's if statements, but are arguably not boolean constants. Rather they are
# castable to booleans. For that reason, this function will not recognize them
# as being of type boolean.
#
# :param _cinb_return: Identifier to hold the result.
# :param _cinb_str2check: The string we are checking for bool-ness
# :type _cinb_str2check: str
# :returns: ``FALSE`` if ``_cinb_str2check`` is lexically castable to a boolean
#           and ``TRUE`` otherwise. The result is returned as ``_cinb_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following code snippet shows how to use ``cpp_is_not_bool`` to determine
# if the provided variable is a boolean.

# .. code-block:: cmake
#
#    include(cmakepp_core/types/bool)
#    set(var2check TRUE)
#    cpp_is_not_bool(result ${var2check})
#    message("var2check is not a bool: ${result}")
#
# The code snippet will print ``var2check is not a bool: FALSE``.
#]]
function(cpp_is_not_bool _cinb_return _cinb_str2check)
    cpp_is_bool(${_cinb_return} "${_cinb_str2check}")
    cpp_negate(${_cinb_return} "${${_cinb_return}}")
    cpp_return(${_cinb_return})
endfunction()

#[[[ Asserts that the provided value is a boolean.
#
# This function will type-check the provided value ensuring it is a boolean.
# If the variable is not a boolean an error will be raised. The type-check only
# occurrs if CMakePP is run in debug mode.
#
# :param _cab_str2check: The string that must be lexically convertible to a
#                        boolean.
# :type _cab_str2check: str
#
# Example Usage:
# ==============
#
# The following code snippet shows how to use ``cpp_assert_bool`` to assert that
# the contents of a variable is a boolean.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/bool)
#    set(a_bool TRUE)
#    cpp_assert_bool(${a_bool})
#]]
function(cpp_assert_bool _cab_str2check)
    cpp_enable_if_debug()
    cpp_is_bool(_cab_result "${_cab_str2check}")
    cpp_assert(${_cab_result} "${_cab_str2check} is bool")
endfunction()
