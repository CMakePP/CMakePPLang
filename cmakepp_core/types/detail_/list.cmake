include_guard()

#[[[ Determines if a string is lexically convertible to a CMake list.
#
# CMake lists are strings that contain semicolons. While CMake's list command
# will treat a string without a semicolon as a list with one element, for the
# purposes of determining if a string is a list we require that the list has at
# least two elements (*i.e.*, there must be a semicolon in it). This function
# determines if the provided string meets this definition of a list.
#
# :param _cil_result: Used as the name of the returned identifier.
# :type _cil_result: desc
# :param _cil_str2check: The string whose listy-ness is being questioned.
# :type _cil_str2check: str
# :returns: ``_cil_result`` will be set to ``TRUE`` if ``_cil_str2check`` is a
#           list and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following snippet shows how to determine if a variable contains a list.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/list)
#    set(a_list 1 2 3)
#    _cpp_is_list(result "${a_list}")
#    message("Is a list: ${result}")  # Will print TRUE
#]]
function(_cpp_is_list _cil_result _cil_str2check)
    list(LENGTH _cil_str2check _cil_length)
    if("${_cil_length}" GREATER 1)
        set("${_cil_result}" TRUE PARENT_SCOPE)
    else()
        set("${_cil_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
