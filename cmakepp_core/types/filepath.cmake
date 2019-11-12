include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)

#[[[ Determines if a string is lexically convertible to an absolute filepath.
#
# This function wraps a call to CMake's ``if(IS_ABSOLUTE ...)`` in order to
# determine if the provided string is lexically convertible to an absolute
# filepath or not.
#
# :param _ciaf_result: An identifier to hold the result.
# :type _ciaf_result: identifier
# :param _ciaf_str2check: The string which may be an absolute filepath.
# :type _ciaf_str: str
# :returns: ``TRUE`` if ``_ciaf_str2check`` is an absolute filepath and
#           ``FALSE`` otherwise. The result is returned via ``_ciaf_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following code snippet checks whether ${CMAKE_BINARY_DIR} is a relative
# directory (it always is by default):
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/filepath)
#    cpp_is_absolute_filepath(result "${CMAKE_BINARY_DIR}")
#    message("Is a filepath: ${result}")  # Prints TRUE
#]]
function(cpp_is_absolute_filepath _ciaf_result _ciaf_str2check)
    cpp_ternary_op(${_ciaf_result} "IS_ABSOLUTE;${_ciaf_str2check}" TRUE FALSE)
    cpp_return(${_ciaf_result})
endfunction()

#[[[ Determines if a string is not an absolute filepath.
#
# This function wraps a call to CMake's ``if(IS_ABSOLUTE ...)`` in order to
# determine if the provided string is lexically convertible to an absolute
# filepath or not.
#
# :param _cinaf_result: An identifier to hold the result.
# :type _cinaf_result: identifier
# :param _cinaf_str2check: The string which may be an absolute filepath.
# :type _cinaf_str: str
# :returns: ``FALSE`` if ``_cinaf_str2check`` is an absolute filepath and
#           ``TRUE`` otherwise. The result is returned via ``_cinaf_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following code snippet checks whether ${CMAKE_BINARY_DIR} is a relative
# directory (it always is by default):
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/filepath)
#    cpp_is_not_absolute_filepath(result "${CMAKE_BINARY_DIR}")
#    message("Is not a filepath: ${result}")  # Prints FALSE
#]]
function(cpp_is_not_absolute_filepath _cinaf_result _cinaf_str2check)
    cpp_is_absolute_filepath(${_cinaf_result} "${_cinaf_str2check}")
    cpp_negate(${_cinaf_result} ${${_cinaf_result}})
    cpp_return(${_cinaf_result})
endfunction()

#[[[ Asserts that a string is an absolute filepath.
#
# This function asserts that the provided string is an absolute filepath. If the
# string is not an absolute filepath an error is raised. The check is only
# performed if CMakePP is in debug mode.
#
# :param _caaf_val2check: The string which should be an absolute filepath.
# :type _caaf_val2check: str
#
# Example Usage:
# ==============
#
# The following code snippet shows how to assert that ``${CMAKE_BINARY_DIR}`` is
# an absolute path:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/filepath)
#    cpp_assert_absolute_filepath(${CMAKE_BINARY_DIR})
#
#]]
function(cpp_assert_absolute_filepath _caaf_val2check)
    cpp_enable_if_debug()
    cpp_is_absolute_filepath(_caaf_return "${_caaf_val2check}")
    cpp_assert("${_caaf_return}" "'${_caaf_val2check}' is an absolute filepath")
endfunction()
