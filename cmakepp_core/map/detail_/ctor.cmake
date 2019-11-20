include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/set)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/unique_id)

#[[[ Creates and assigns a new map to the specified identifier.
#
# This function is the constructor for the CMakePP map object.
#
# :param _cmc_name: An identifier to hold the newly created map. ``_cmc_name``
#                   will play the role of the "this pointer" for the newly
#                   created map.
# :type _cmc_name: identifier
# :param *args: A list of (key,value)-pairs to initialize the map with.
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
    cpp_assert_signature("${ARGV}" desc args)
    cpp_unique_id("${_cmc_name}")
    define_property(
        GLOBAL PROPERTY ${${_cmc_name}}_keys BRIEF_DOCS "keys" FULL_DOCS "keys"
    )
    set_property(GLOBAL PROPERTY "${${_cmc_name}}_type" "map")
    if(${ARGC} GREATER 1)
        set(_cmc_key_i 1)
        set(_cmc_value_i 2)
        while("${_cmc_key_i}" LESS "${ARGC}")
            _cpp_map_set(
                "${${_cmc_name}}"
                "${ARGV${_cmc_key_i}}"
                "${ARGV${_cmc_value_i}}"
            )
            math(EXPR _cmc_key_i "${_cmc_key_i} + 2")
            math(EXPR _cmc_value_i "${_cmc_value_i} + 2")
        endwhile()
    endif()
    cpp_return(${_cmc_name})
endfunction()






