include_guard()
include(cmakepp_lang/types/list)

#[[[
# Determines if a string is lexically convertible to an absolute filepath.
#
# This function wraps a call to CMake's ``if(IS_ABSOLUTE ...)`` in order to
# determine if the provided string is lexically convertible to an absolute
# filepath.
#
# :param _ip_result: An identifier to hold the result.
# :type _ip_result: identifier
# :param _ip_str2check: The string which may be an absolute filepath.
# :type _ip_str: str
# :returns: ``TRUE`` if ``_ip_str2check`` is an absolute filepath and
#           ``FALSE`` otherwise. The result is returned via ``_cip_result``.
# :rtype: bool
#
# Example Usage
# =============
#
# The following code snippet checks whether ${CMAKE_BINARY_DIR} is a relative
# directory (it always is by default):
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/filepath)
#    cpp_is_path(result "${CMAKE_BINARY_DIR}")
#    message("Is a filepath: ${result}")  # Prints TRUE
#
# Error Checking
# ==============
#
# ``cpp_is_path`` will assert that the caller has provided exactly two
# arguments. If this is not the case an error will be raised.
#]]
function(cpp_is_path _ip_result _ip_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_path takes exactly 2 arguments.")
    endif()

    # Hard to get the if-statement to keep lists together so bail early if list
    cpp_is_list(_ip_is_list "${_ip_str2check}")
    if(_ip_is_list)
        set("${_ip_result}" FALSE PARENT_SCOPE)
    elseif(IS_ABSOLUTE "${_ip_str2check}")
        set("${_ip_result}" TRUE PARENT_SCOPE)
    else()
        set("${_ip_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
