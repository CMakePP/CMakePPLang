include_guard()
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/ternary_op)

#[[[ Tests whether a string is the empty string.
#
# :param _cies_return: Identifier to hold the result.
# :type _cies_return: identifier
# :param _cies_str2check: The string we are checking for emptyness.
# :type _cies_str2check: str
# :returns: ``TRUE`` if ``_cies_str2check`` compares equal to the empty string
#           and ``FALSE`` otherwise. Result is returned via ``_cies_return``.
# :rtype: bool
#
# Example Usage
# =============
#
# .. code-block:: cmake
#
#    include(cmakepp_core/type/empty_string)
#    set(a_str "")  # Pretend we got this variable from somewhere else
#    cpp_is_empty_string(result "${a_str}")
#    message("Was the variable empty: ${result}")  # Should print TRUE
#
# .. note::
#
#    We use macro instead of function to avoid a needless forward of the result.
#]]
macro(cpp_is_empty_string _cies_return _cies_str2check)
    cpp_ternary_op(${_cies_return} "${_cies_str2check} ;STREQUAL; " TRUE FALSE)
endmacro()

#[[[ Tests that a string is not the empty string.
#
# :param _cines_return: Identifier to hold the result.
# :type _cines_return: identifier
# :param _cines_str2check: The string we are checking for emptyness.
# :type _cines_str2check: str
# :returns: ``FALSE`` if ``_cines_str2check`` compares equal to the empty string
#           and ``TRUE`` otherwise. Result is returned via ``_cines_return``.
# :rtype: bool
#
# Example Usage
# =============
#
# .. code-block:: cmake
#
#    include(cmakepp_core/type/empty_string)
#    set(a_str "")  # Pretend we got this variable from somewhere else
#    cpp_is_not_empty_string(result "${a_str}")
#    message("Was the variable empty: ${result}")  # Should print FALSE
#
# .. note::
#
#    We use macro instead of function to avoid a needless forward of the result.
#]]
macro(cpp_is_not_empty_string _cines_return _cines_str2check)
    cpp_is_empty_string("${_cines_return}" "${_cines_str2check}")
    cpp_negate("${_cines_return}" "${${_cines_return}}")
endmacro()
