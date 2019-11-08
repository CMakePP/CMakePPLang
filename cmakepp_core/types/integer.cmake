include_guard()
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

function(cpp_is_not_int _cini_return _cini_str2check)
    string(REGEX MATCH "^-?[0-9]+\$" _cini_match "${_cini_str2check}")
    cpp_is_empty(${_cini_return} "${_cini_match}")
    cpp_return(${_cini_return})
endfunction()
