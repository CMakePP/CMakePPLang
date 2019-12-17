include_guard()

#[[[ Determines if a string can be leixically cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function.
#
# :param _ii_return: The name to use for the variable holding the result.
# :type _ii_return: desc
# :param _ii_str2check: The string we are checking for its emptyness.
# :type _ii_str2check: str
# :returns: ``_ii_return`` will be set to ``TRUE`` if ``_ii_str2check`` is an
#           integer and ``FALSE`` otherwise.
# :rtype: bool*
#]]
function(cpp_is_int _ii_return _ii_str2check)

    string(REGEX MATCH "^-?[0-9]+\$" _ii_match "${_ii_str2check}")
    if("${_ii_match}" STREQUAL "")
        set("${_ii_return}" FALSE PARENT_SCOPE)
    else()
        set("${_ii_return}" TRUE PARENT_SCOPE)
    endif()
endfunction()
