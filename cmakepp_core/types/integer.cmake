include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/negate)
include(cmakepp_core/utilities/return)
include(cmakepp_core/types/string)

#[[[ Determines if a string can be leixically cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function.
#
# :param _cii_return: An identifier to store the result.
# :type _cii_return: identifier
# :param _cii_str2check: The string we are checking for its emptyness.
# :type _cii_str2check: str
# :returns: ``TRUE`` if ``_cii_str2check`` is an integer and ``FALSE``
#           otherwise. The result is returned via ``_cii_return``.
# :rtype: bool
#]]
function(cpp_is_int _cii_return _cii_str2check)
    string(REGEX MATCH "^-?[0-9]+\$" _cii_match "${_cii_str2check}")
    cpp_is_not_empty(${_cii_return} "${_cii_match}")
    cpp_return(${_cii_return})
endfunction()

#[[[ Determines if a string can not be leixically cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function.
#
# :param _cini_return: An identifier to store the result.
# :type _cini_return: identifier
# :param _cini_str2check: The string we are checking for its emptyness.
# :type _cini_str2check: str
# :returns: ``FALSE`` if ``_cini_str2check`` is an integer and ``TRUE``
#           otherwise. The result is returned via ``_cini_return``.
# :rtype: bool
#]]
function(cpp_is_not_int _cini_return _cini_str2check)
    cpp_is_int(${_cini_return} "${_cini_str2check}")
    cpp_negate(${_cini_return} "${${_cini_return}}")
    cpp_return(${_cini_return})
endfunction()

#[[[ Asserts that the provided argument is an integer.
#
# This function is meant to be used for type-checking when CMakePP is run in
# debug mode. If CMakePP is in debug mode and the argument provided to this
# function is not an integer, this function will raise an error.
#
# :param _cai_val2check: String to lexically cast to an integer
# :type _cai_val2check: str
#
# Example Usage:
# ==============
#
# This example shows how to assert that the contents of a variable is an
# integer. This is typically done as a means of error-checking inside a function
# where the value of the variable is not so clear.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/integer)
#    set(an_int 42)
#    cpp_assert_int(${an_int})
#]]
function(cpp_assert_int _cai_val2check)
    cpp_enable_if_debug()
    cpp_is_int(_cai_return "${_cai_val2check}")
    cpp_assert("${_cai_return}" "'${_cai_val2check}' is an integer")
endfunction()
