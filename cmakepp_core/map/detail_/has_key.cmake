include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/logic/contains)
include(cmakepp_core/map/detail_/keys)

#[[[ Determines whether the specified map has the specified key.
#
# This function is used to determine if a given key has been set for a given
# map.
#
# :param _cmhk_result: The name to use for the variable holding the result.
# :type _cmhk_result: desc
# :param _cmhk_map: The map we are searching in order to find the key.
# :type _cmhk_map: map
# :param _cmhk_key: The key we are looking for.
# :type _cmhk_key: desc
#]]
function(_cpp_map_has_key _cmhk_result _cmhk_map _cmhk_key)
    cpp_assert_type(
        desc "${_cmhk_result}" map "${_cmhk_map}" desc "${_cmhk_key}"
    )
    _cpp_map_keys(_cmhk_keys "${_cmhk_map}")
    cpp_contains("${_cmhk_result}" "${_cmhk_key}" "${_cmhk_keys}")
    cpp_return("${_cmhk_result}")
endfunction()
