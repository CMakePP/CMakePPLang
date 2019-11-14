include_guard()
include(cmakepp_core/types/detail_/list)

#[[[ Determines if a string is lexically convertible to an absolute filepath.
#
# This function wraps a call to CMake's ``if(IS_ABSOLUTE ...)`` in order to
# determine if the provided string is lexically convertible to an absolute
# filepath or not.
#
# :param _ciaf_result: An identifier to hold the result.
# :type _ciaf_result: identifier
# :param _ciaf_str2check: The string which may be an absolute filepath.
# :type _ciaf_str: str
# :returns: ``TRUE`` if ``_ciaf_str2check`` is an absolute filepath and
#           ``FALSE`` otherwise. The result is returned via ``_ciaf_result``.
# :rtype: bool
#
# Example Usage:
# ==============
#
# The following code snippet checks whether ${CMAKE_BINARY_DIR} is a relative
# directory (it always is by default):
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/filepath)
#    cpp_is_absolute_filepath(result "${CMAKE_BINARY_DIR}")
#    message("Is a filepath: ${result}")  # Prints TRUE
#]]
function(_cpp_is_filepath _cif_result _cif_str2check)
    # Getting the if-statement to keep lists together so bail out early if list
    _cpp_is_list(_cif_is_list "${_cif_str2check}")
    if(_cif_is_list)
        set(${_cif_result} FALSE PARENT_SCOPE)
    elseif(IS_ABSOLUTE "${_cif_str2check}")
        set(${_cif_result} TRUE PARENT_SCOPE)
    else()
        set(${_cif_result} FALSE PARENT_SCOPE)
    endif()
endfunction()
