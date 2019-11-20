include_guard()
include(cmakepp_core/types/detail_/map)

#[[[ Determines if a CMake string is lexically convertibale to a CMakePP array.
#
# CMakePP arrays are based off a "this pointer". Basically the "this pointer" is
# a unique prefix for all variables associated with a particular array instance.
# This function looks to see if the provided string has the correct form to be
# a this pointer for a CMakePP array.
#
# :param _cia_result: Name of the variable to hold the result.
# :type _cia_result: desc
# :param _cia_array: String we want to know the array-ness of.
# :type _cia_array: str
# :returns: ``_cia_result`` will contain ``TRUE`` if ``_cia_array`` is an array
#           and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following code snippet determines whether or not the contents of a
# variable is a CMakePP array.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/array)
#    _cpp_array_ctor(my_array)
#    _cpp_is_array(result "${my_array}")
#    message("Is an array: ${result}")  # Prints true
#]]
function(_cpp_is_array _cia_result _cia_array)
    _cpp_is_list(_cia_list "${_cia_array}")
    if(NOT "${_cia_list}" AND _cia_array)
        get_property(_cia_contents GLOBAL PROPERTY "${_cia_array}")
        get_property(_cia_type GLOBAL PROPERTY "${_cia_array}_type")
        _cpp_is_map(_cia_is_map "${_cia_contents}")
        if(_cia_is_map AND "${_cia_type}" STREQUAL "array")
            set(${_cia_result} TRUE PARENT_SCOPE)
            return()
        endif()
    endif()
    set(${_cia_result} FALSE PARENT_SCOPE)
endfunction()
