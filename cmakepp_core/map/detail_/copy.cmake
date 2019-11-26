include_guard()
include(cmakepp_core/algorithm/copy)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/ctor)
include(cmakepp_core/map/detail_/get)
include(cmakepp_core/map/detail_/keys)
include(cmakepp_core/map/detail_/set)
include(cmakepp_core/utilities/return)

#[[[ Creates a new CMakePP instance which is a deep copy of another instance.
#
# This function will create a new map, which is a deep copy of an already
# existing map. The two maps will initially have the same state. Changes to
# either map will not be reflected in the other map.
#
# :param _cmc_result: The name for the variable to hold the resulting copy.
# :type _cmc_result: desc
# :param _cmc_map2copy: The map we are copying.
# :type _cmc_map2copy: map
# :returns: ``_cmc_result`` will be set to a deep copy of ``_cmc_map2copy``.
# :rtype: map*
#
#]]
function(_cpp_map_copy _cmc_result _cmc_map2copy)
    cpp_assert_signature("${ARGV}" desc map)

    _cpp_map_ctor("${_cmc_result}")
    _cpp_map_keys(_cmc_keys "${_cmc_map2copy}")
    foreach(_cmc_key_i ${_cmc_keys})
        _cpp_map_get(_cmc_value_i "${_cmc_map2copy}" "${_cmc_key_i}")
        cpp_copy(_cmc_key_copy "${_cmc_key_i}")
        cpp_copy(_cmc_value_copy "${_cmc_value_i}")
        _cpp_map_set(
            "${${_cmc_result}}" "${_cmc_key_copy}" "${_cmc_value_copy}"
        )
    endforeach()
    cpp_return("${_cmc_result}")
endfunction()
