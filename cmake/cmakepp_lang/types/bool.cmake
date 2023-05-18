include_guard()
include(cmakepp_lang/types/literals)

#[[[
# Determines if the provided string can lexically be cast to a boolean.
#
# This function will compare the provided string against the list of boolean
# literals known to CMakePP. The actual string comparison is done in a
# case-insensitive manner.
#
# :param return: Name of the variable used to hold the return.
# :type return: desc
# :param str2check: The string we are checking for its bool-ness
# :type str2check: str
# :returns: ``return`` will contain ``TRUE`` if ``str2check`` is one
#           of the recognized boolean literals and ``FALSE`` otherwise.
# :rtype: bool
# :var CMAKEPP_BOOL_LITERALS: Used to get the list of boolean literals.
#
# Example Usage
# =============
#
# The following code snippet shows how to use ``cpp_is_bool`` to determine if
# the provided variable is a boolean.
# 
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/bool)
#    set(var2check TRUE)
#    cpp_is_bool(result "${var2check}")
#    message("var2check is a bool: ${result}")  # will print TRUE
# 
# Error Checking
# ==============
#
# ``cpp_is_bool`` will ensure that it has been called with exactly two
# arguments.
#]]
function(cpp_is_bool _ib_return _ib_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_bool accepts exactly 2 arguments")
    endif()

    # Boolean literals are stored uppercase
    string(TOUPPER "${_ib_str2check}" _ib_str2check)

    # Loop over the known boolean literals
    foreach(_ib_bool_i ${CMAKEPP_BOOL_LITERALS})

        # Compare input to known literal i, if match, return true
        if("${_ib_str2check}" STREQUAL "${_ib_bool_i}")
            set(${_ib_return} TRUE PARENT_SCOPE)
            return()
        endif()

    endforeach()

    # Finally check if -NOTFOUND is the last 9 characters
    string(REGEX MATCH [[^.*-NOTFOUND$]] _ib_notfound_suffix "${_ib_str2check}")

    if(NOT "${_ib_notfound_suffix}" STREQUAL "")
        set("${_ib_return}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Getting here means it's not a known boolean literal, so return false
    set(${_ib_return} FALSE PARENT_SCOPE)
endfunction()
