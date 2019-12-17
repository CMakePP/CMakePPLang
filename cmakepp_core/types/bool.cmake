include_guard()
include(cmakepp_core/types/literals)

#[[[ Determines if the provided string can lexically be cast to a boolean.
#
# This function will compare the provided string against the list of boolean
# literals known to CMakePP. The actual string comparison is done in a
# case-insensitive manner.
#
# :param _cib_return: Name which should be used for the returned identifier.
# :type  _cib_return: desc
# :param _cib_str2check: The string we are checking for bool-ness
# :type _cib_str2check: str
# :returns: ``_cib_return`` will contain ``TRUE`` if ``_cib_str2check`` is one
#           of the recognized boolean literals and ``FALSE`` otherwise.
# :rtype: bool*
# :var CMAKEPP_BOOL_LITERALS: Used to get the list of boolean literals.
#
# Example Usage:
# ==============
#
# The following code snippet shows how to use ``cpp_is_bool`` to determine if
# the provided variable is a boolean.

# .. code-block:: cmake
#
#    include(cmakepp_core/types/bool)
#    set(var2check TRUE)
#    cpp_is_bool(result ${var2check})
#    message("var2check is a bool: ${result}")  # will print TRUE
#
#]]
function(cpp_is_bool _ib_return _ib_str2check)

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

    # Getting here means it's not a known boolean literal, so return false
    set(${_ib_return} FALSE PARENT_SCOPE)
endfunction()
