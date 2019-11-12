include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)

#[[[ Determines if a string is the name of a target.
#
# CMake maintains an internal list of targets and allows us to query whether a
# particular identifier is a target via CMake's native ``if`` statement. This
# function simply wraps a call to ``if(TARGET ...)``.
#
# :param _cit_return: An identifier to store the result.
# :type _cit_return: identifier
# :param _cit_str2check: The string whose targety-ness is in question
# :type _cit_str2check: str
# :returns: ``TRUE`` if ``_cit_str2check`` is a target and ``FALSE`` otherwise.
#           The result is returned via ``_cit_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``my_target`` is a target:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/target)
#    add_library(my_target STATIC IMPORTED)
#    cpp_is_target(return ${my_target})
#    message("my_target is a target: ${return}")  # prints TRUE
#]]
function(cpp_is_target _cit_return _cit_str2check)
    cpp_ternary_op(${_cit_return} "TARGET;${_cit_str2check}" TRUE FALSE)
    cpp_return(${_cit_return})
endfunction()

#[[[ Determines if a string is not the name of a target.
#
# CMake maintains an internal list of targets and allows us to query whether a
# particular identifier is a target via CMake's native ``if`` statement. This
# function simply wraps negating a call to ``if(TARGET ...)``.
#
# :param _cint_return: An identifier to store the result.
# :type _cint_return: identifier
# :param _cint_str2check: The string whose targety-ness is in question
# :type _cint_str2check: str
# :returns: ``FALSE`` if ``_cint_str2check`` is a target and ``TRUE`` otherwise.
#           The result is returned via ``_cint_return``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following is an example showcasing how one would check if the identifier
# ``my_target`` is not a target:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/target)
#    add_library(my_target STATIC IMPORTED)
#    cpp_is_not_target(return ${my_target})
#    message("my_target is not a target: ${return}")  # prints FALSE
#]]
function(cpp_is_not_target _cint_return _cint_str2check)
    cpp_is_target(${_cint_return} "${_cint_str2check}")
    cpp_negate(${_cint_return} "${${_cint_return}}")
    cpp_return(${_cint_return})
endfunction()

#[[[ Asserts that the provided argument is a target.
#
# This function is meant to be used for type-checking when CMakePP is run in
# debug mode. If CMakePP is in debug mode and the argument provided to this
# function is not a target, this function will raise an error.
#
# :param _cat_val2check: String which should be the name of a target.
# :type _cat_val2check: str
#
# Example Usage:
# ==============
#
# This example shows how to assert that a string is the name of an existing
# target. This is typically done as a means of error-checking inside a function
# where the value of the variable is not so clear.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/target)
#    add_library(my_target STATIC IMPORTED)
#    cpp_assert_target(my_target)
#]]
function(cpp_assert_target _cat_val2check)
    cpp_enable_if_debug()
    cpp_is_target(_cat_return "${_cat_val2check}")
    cpp_assert("${_cat_return}" "'${_cat_val2check}' is a target")
endfunction()
