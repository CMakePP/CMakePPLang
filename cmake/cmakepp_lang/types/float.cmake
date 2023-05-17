include_guard()

#[[[
# Determines if a string can be lexically cast to a float.
#
# For our purposes a float is any string whose only characters include a decimal
# point, and the numbers 0 through 9. Optionally the float may be prefixed with
# a minus sign.
#
# :param _if_return: Name for the variable used to store the result.
# :type _if_return: desc
# :param _if_str2check: The string we are checking for its floaty-ness
# :type _if_str2check: str
# :returns: ``_if_return`` will be set to ``TRUE`` if ``_if_str2check`` is a
#           float and ``FALSE`` otherwise.
# :rtype: bool
#
# Example Usage
# =============
#
# The following is an example showcasing how one would check if the identifier
# ``x`` contained a float.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/float)
#    set(x 3.14)
#    cpp_is_float(return ${x})
#    message("3.14 is a float: ${return}")  # prints TRUE
# 
# Error Checking
# ==============
#
# ``cpp_is_float`` will assert that it is called with exactly two arguments. If
# it is not an error will be raised.
#]]
function(cpp_is_float _if_return _if_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_float accepts exactly 2 arguments")
    endif()

    # Note: Regex pattern strings in CMake require 2 backslashes to escape
    # characters (must escape CMake string first)
    string(REGEX MATCH "^-?[0-9]+\\.[0-9]+\$" _if_match "${_if_str2check}")

    if("${_if_match}" STREQUAL "")
        set(${_if_return} FALSE PARENT_SCOPE)
    else()
        set(${_if_return} TRUE PARENT_SCOPE)
    endif()
endfunction()
