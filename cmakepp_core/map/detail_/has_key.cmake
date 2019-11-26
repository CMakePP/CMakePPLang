include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/keys)

#[[[ Determines whether the specified map has the specified key.
#
# This function is used to determine if a given map has a given key. Note that
# text-like keys are stored in a case-insensitive manner.
#
# :param _cmhk_result: The name to use for the variable holding the result.
# :type _cmhk_result: desc
# :param _cmhk_map: The map we are searching in order to find the key.
# :type _cmhk_map: map
# :param _cmhk_key: The key we are looking for.
# :type _cmhk_key: str
#]]
function(_cpp_map_has_key _cmhk_result _cmhk_map _cmhk_key)
    cpp_assert_signature("${ARGV}" desc map str)

    _cpp_map_keys(_cmhk_keys "${_cmhk_map}")
    string(TOLOWER "${_cmhk_key}" _cmhk_key)
    if("${_cmhk_key}" IN_LIST _cmhk_keys)
        set("${_cmhk_result}" TRUE PARENT_SCOPE)
    else()
        set("${_cmhk_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
