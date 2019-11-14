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
# The following code snippet shows how to use ``_cpp_is_bool`` to determine if
# the provided variable is a boolean.

# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/bool)
#    set(var2check TRUE)
#    _cpp_is_bool(result ${var2check})
#    message("var2check is a bool: ${result}")  # will print TRUE
#
# It should be noted that ``_cpp_is_bool`` is an implementation detail. Users
# should go through the public API ``cpp_is_type``.
#]]
function(_cpp_is_bool _cib_return _cib_str2check)
    string(TOUPPER "${_cib_str2check}" _cib_str2check)
    foreach(_cib_bool_i ${CMAKEPP_BOOL_LITERALS})
        if("${_cib_str2check}" STREQUAL "${_cib_bool_i}")
            set(${_cib_return} TRUE PARENT_SCOPE)
            return()
        endif()
    endforeach()
    set(${_cib_return} FALSE PARENT_SCOPE)
endfunction()
