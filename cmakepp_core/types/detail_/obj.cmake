include_guard()
include(cmakepp_core/types/detail_/list)
include(cmakepp_core/types/detail_/map)

#[[[ Determines if a CMake string is lexically convertibale to a CMakePP object.
#
# :param _cio_result: Name of the variable to hold the result.
# :type _cio_result: desc
# :param _cio_obj: String we want to know the object-ness of.
# :type _cio_obj: str
# :returns: ``_cio_result`` will contain ``TRUE`` if ``_cio_obj`` is an object
#            and ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following code snippet determines whether or not the contents of a
# variable is a CMakePP object.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/obj)
#    _cpp_obj_ctor(an_obj)
#    _cpp_is_obj(result "${an_obj}")
#    message("Is an object: ${result}")  # Prints true
#]]
function(_cpp_is_obj _cio_result _cio_obj)
    set("${_cio_result}" FALSE PARENT_SCOPE)

    _cpp_is_list(_cio_list "${_cio_obj}")
    if(_cio_list)
        return()
    endif()

    get_property(_cio_state GLOBAL PROPERTY "${_cio_obj}")
    _cpp_is_map(_cio_state_is_map "${_cio_state}")
    if(NOT "${_cio_state_is_map}")
        return()
    endif()

    get_property(_cio_is_obj GLOBAL PROPERTY "${_cio_obj}_type")
    if("${_cio_is_obj}" STREQUAL "obj")
        set("${_cio_result}" TRUE PARENT_SCOPE)
    endif()
endfunction()
