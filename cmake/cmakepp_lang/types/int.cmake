include_guard()

#[[[ Determines if a string can lexically be cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function (note the space in ``" 2"``).
#
# :param _ii_return: The name to use for the variable holding the result.
# :type _ii_return: desc
# :param _ii_str2check: The string which may be an integer.
# :type _ii_str2check: str
# :returns: ``_ii_return`` will be set to ``TRUE`` if ``_ii_str2check`` is an
#           integer and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# ``cpp_is_int`` will ensure that the caller has provided exactly two arguments.
# If the caller has provided a different amount of arguments this function will
# raise an error.
#]]
function(cpp_is_int _ii_return _ii_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_int takes exactly 2 arguments.")
    endif()

    string(REGEX MATCH "^-?[0-9]+\$" _ii_match "${_ii_str2check}")
    if("${_ii_match}" STREQUAL "")
        set("${_ii_return}" FALSE PARENT_SCOPE)
    else()
        set("${_ii_return}" TRUE PARENT_SCOPE)
    endif()
endfunction()
