include_guard()
include(cmakepp_core/map/ctor)

#[[[ Determines if a CMake string is lexically convertibale to a CMakePP map.
#
# CMakePP maps are based off a "this pointer". Basically the "this pointer" is
# a unique prefix for all variables associated with a particular map instance.
# This function looks to see if the provided string has the correct form to be
# a this pointer for a CMakePP map. This function also verifies that the correct
# attributes have been defined for the map.
#
# :param _cim_result: Name of the variable to hold the result.
# :type _cim_result: desc
# :param _cim_map: String we want to know the mapy-ness of.
# :type _cim_map: str
# :returns: ``_cim_result`` will contain ``TRUE`` if ``_cim_map`` is a map and
#           ``FALSE`` otherwise.
# :rtype: bool*
#
# Example Usage:
# ==============
#
# The following code snippet determines whether or not the contents of a
# variable is a CMakePP map.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/detail_/map)
#    _cpp_map_ctor(my_map)
#    _cpp_is_map(result "${my_map}")
#    message("Is a map: ${result}")  # Prints true
#]]
function(_cpp_is_map _cim_result _cim_map)
    _cpp_map_mangle(_cim_mangle)
    if("${_cim_mangle}" STRLESS "${_cim_map}")

        get_property(_cim_is_defined GLOBAL PROPERTY "${_cim_map}_keys" DEFINED)
        if(_cim_is_defined)
            set(${_cim_result} TRUE PARENT_SCOPE)
            return()
        endif()

    endif()
    set(${_cim_result} FALSE PARENT_SCOPE)
endfunction()
