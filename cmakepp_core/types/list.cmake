include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)

#[[[ Determines if a string is lexically convertible to a CMake list.
#
# CMake lists are strings that contain semicolons. While CMake's list command
# will treat a string without a semicolon as a list with one element, for the
# purposes of determining if a string is a list we require that the list have at
# least two elements (*i.e.*, there must be a semicolon in it). This function
# determines if the provided string meets this definition of a list.
#
# :param _cil_result: Identifier used to store the result.
# :type _cil_result: identifier
# :param _cil_str2check: The string which may be a list.
# :type _cil_str2check: str
# :returns: ``TRUE`` if ``_cil_str2check`` is a list and ``FALSE`` otherwise.
#           The result is returned via ``_cil_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if a variable contains a list.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/list)
#    set(a_list 1 2 3)
#    cpp_is_list(result "${a_list}")
#    message("Is a list: ${result}")  # Will print TRUE
#]]
function(cpp_is_list _cil_result _cil_str2check)
    list(LENGTH _cil_str2check ${_cil_result})
    cpp_ternary_op(${_cil_result} "${${_cil_result}};GREATER;1" TRUE FALSE)
    cpp_return(${_cil_result})
endfunction()

#[[[ Determines if a string is not lexically convertible to a CMake list.
#
# CMake lists are strings that contain semicolons. While CMake's list command
# will treat a string without a semicolon as a list with one element, for the
# purposes of determining if a string is a list we require that the list have at
# least two elements (*i.e.*, there must be a semicolon in it). This function
# determines if the provided string does not meet the definition of a list.
#
# :param _cinl_result: Identifier used to store the result.
# :type _cinl_result: identifier
# :param _cinl_str2check: The string which may be a list.
# :type _cinl_str2check: str
# :returns: ``FALSE`` if ``_cinl_str2check`` is a list and ``TRUEE`` otherwise.
#           The result is returned via ``_cinl_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if a variable does not contain a
# list.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/list)
#    set(a_list 1 2 3)
#    cpp_is_not_list(result "${a_list}")
#    message("Is not a list: ${result}")  # Will print FALSE
#]]
function(cpp_is_not_list _cinl_result _cinl_str2check)
    cpp_is_list(${_cinl_result} "${_cinl_str2check}")
    cpp_negate(${_cinl_result} ${${_cinl_result}})
    cpp_return(${_cinl_result})
endfunction()

#[[[ Asserts that the provided value is a list.
#
# This function can be used to type-check a variable and ensure that it does
# contain a list. The type-check is only performed if CMakePP is run in debug
# mode and if the assert fails an error will be raised.
#
# :param _cal_str2check: The string which should be a list.
# :type _cal_str2check: str
# :var CMAKEPP_CORE_DEBUG_MODE: Must be set to a true value in order for the
#                               check to actually occur.
# Example Usage:
# ==============
#
# The following code snippet demonstrates how to assert that a value is a list.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/list)
#    set(a_list 1 2 3)
#    cpp_assert_list("${a_list}")
#]]
function(cpp_assert_list _cal_str2check)
    cpp_enable_if_debug()
    cpp_is_list(_cal_result "${_cal_str2check}")
    cpp_assert(${_cal_result} "'${_cal_str2check}' is a list")
endfunction()
