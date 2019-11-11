include_guard()
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/ternary_op)

#[[[ Tests whether a string is the empty string.
#
# :param _cie_return: Identifier to hold the result.
# :type _cie_return: identifier
# :param _cie_str2check: The string we are checking for emptyness.
# :type _cie_str2check: str
# :returns: ``TRUE`` if ``_cie_str2check`` compares equal to the empty string
#           and ``FALSE`` otherwise. Result is returned via ``_cie_return``.
# :rtype: bool
#
# Example Usage
# =============
#
# .. code-block:: cmake
#
#    include(cmakepp_core/type/string)
#    set(a_str "")  # Pretend we got this variable from somewhere else
#    cpp_is_empty(result "${a_str}")
#    message("Was the variable empty: ${result}")  # Should print TRUE
#
# .. note::
#
#    We use macro instead of function to avoid a needless forward of the result.
#]]
macro(cpp_is_empty _cie_return _cie_str2check)
    cpp_ternary_op(${_cie_return} "${_cie_str2check} ;STREQUAL; " TRUE FALSE)
endmacro()

#[[[ Tests that a string is not the empty string.
#
# :param _cine_return: Identifier to hold the result.
# :type _cine_return: identifier
# :param _cine_str2check: The string we are checking for emptyness.
# :type _cine_str2check: str
# :returns: ``FALSE`` if ``_cine_str2check`` compares equal to the empty string
#           and ``TRUE`` otherwise. Result is returned via ``_cine_return``.
# :rtype: bool
#
# Example Usage
# =============
#
# .. code-block:: cmake
#
#    include(cmakepp_core/type/string)
#    set(a_str "")  # Pretend we got this variable from somewhere else
#    cpp_is_not_empty(result "${a_str}")
#    message("Was the variable empty: ${result}")  # Should print FALSE
#
# .. note::
#
#    We use macro instead of function to avoid a needless forward of the result.
#]]
macro(cpp_is_not_empty _cine_return _cine_str2check)
    cpp_is_empty("${_cine_return}" "${_cine_str2check}")
    cpp_negate("${_cine_return}" "${${_cine_return}}")
endmacro()
