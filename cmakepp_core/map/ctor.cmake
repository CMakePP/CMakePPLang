include_guard()
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/ternary_op)

#[[[ Encapsulates the logic behind how we mangle the "this pointer" for a map.
#
# This function will take the input identifier and mangle the string it contains
# in such a way that CMakePP can identify the string as being the "this pointer"
# for a map. The exact mangling is considered an implemntation detail, but can
# be accessed at runtime by providing an identifier that contains an empty
# string. After the call the identifier will be set to the prefix used for
# mangling (the final mangled name being obtained by concatenating the prefix
# with the contents of the provided identifier). This function is not part of
# the map's public API and should not be called from outside CMakePP core.
#
# :param _cmm_this_ptr: An identifier which will be set to the "this pointer" of
#                       the resulting map. The input contents of this variable
#                       will be used to seed the result and should be unique or
#                       else the resulting map will overwrite an existing map.
# :type _cmm_this_ptr: identifier
# :returns: The unique name of this map. The result is returned via the
#           ``_cmm_this_ptr`` variable.
# :rtype: str
#]]
function(_cpp_map_mangle _cmm_this_ptr)
    set(${_cmm_this_ptr} "__cpp_map_${${_cmm_this_ptr}}" PARENT_SCOPE)
endfunction()

#[[[ Creates and assigns a new map to the specified identifier.
#
# This function is the constructor for the CMakePP map object.
#
# :param _cmc_name: An identifier to hold the newly created map. ``_cmc_name``
#                   will play the role of the "this pointer" for the newly
#                   created map.
# :type _cmc_name: identifier
# :returns: A newly created map instance. The map is returned via the
#           ``_cmc_name`` parameter.
# :rtype: map
#
# Example Usage:
# ==============
#
# To set the identifier ``my_map`` to a newly constructed map the syntax is:
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/ctor)
#    _cpp_map_ctor(my_map)
#
# After this call the map can be accessed like ``${my_map}``.
#]]
function(_cpp_map_ctor _cmc_name)
    string(RANDOM ${_cmc_name})
    _cpp_map_mangle(${_cmc_name})
    define_property(
        GLOBAL PROPERTY ${${_cmc_name}}_keys BRIEF_DOCS "keys" FULL_DOCS "keys"
    )
    cpp_return(${_cmc_name})
endfunction()






