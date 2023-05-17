include_guard()
include(cmakepp_lang/types/cmakepp_type)

#[[[
# Determines if a string is lexically convertible to a command.
#
# This function wraps a call to CMake's ``if(COMMAND ...)`` in order to
# determine if the provided string is lexically convertible to a command or not.
# Commands can be native CMake functions or user-defined macro/functions. It
# should be noted that for CMakePP functions it is the mangled name of the
# function which is identified as a command.
#
# :param result: Name for variable which will hold the result of the check.
# :type result: desc
# :param str2check: The string which may be a command.
# :type str: str
# :returns: ``TRUE`` if ``_if_str2check`` is a command and ``FALSE`` otherwise. 
#            The result is returned via ``_cip_result``.
# :rtype: bool
#
# Example Usage
# =============
#
# The following code snippet checks whether ``add_subdirectory`` is a command:
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/fxn)
#    cpp_is_fxn(result add_subdirectory)
#    message("Is a command: ${result}")  # Prints TRUE
#]]
function(cpp_is_fxn _if_result _if_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_fxn accepts exactly 2 arguments")
    endif()

    _cpp_get_cmakepp_type(_if_is_obj _ "${_if_str2check}")
    string(TOLOWER "${_if_str2check}" _if_lc_str2check)

    if("${_if_is_obj}")
        set("${_if_result}" FALSE PARENT_SCOPE)
    elseif("${_if_lc_str2check}" STREQUAL list)
        set("${_if_result}" FALSE PARENT_SCOPE)
    elseif(COMMAND "${_if_str2check}")
        set("${_if_result}" TRUE PARENT_SCOPE)
    else()
        set("${_if_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
