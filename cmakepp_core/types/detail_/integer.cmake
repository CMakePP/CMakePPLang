include_guard()

#[[[ Determines if a string can be leixically cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function.
#
# :param _cii_return: The name to use for the variable holding the result.
# :type _cii_return: desc
# :param _cii_str2check: The string we are checking for its emptyness.
# :type _cii_str2check: str
# :returns: ``_cii_return`` will be set to ``TRUE`` if ``_cii_str2check`` is an
#           integer and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(_cpp_is_int _cii_return _cii_str2check)
    string(REGEX MATCH "^-?[0-9]+\$" _cii_match "${_cii_str2check}")
    if("${_cii_match}" STREQUAL "")
        set(${_cii_return} FALSE PARENT_SCOPE)
    else()
        set(${_cii_return} TRUE PARENT_SCOPE)
    endif()
endfunction()
