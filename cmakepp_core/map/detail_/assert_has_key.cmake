include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/has_key)
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)

#[[[ Code factorization for asserting that the map has a key.
#
# This function examines the provided map for the requested key. If the key is
# found this function simply returns. If the key is not found then this function
# raises an error. The actual check for the key is only performed if CMakePP is
# in debug mode.
#
# :param _cmahk_map: The map which should have the key.
# :type _cmahk_map: map
# :param _cmahk_key: The key which the map should have.
# :type _cmahk_key: str
# :var  CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMake is in debug mode or
#                                not.
#]]
function(_cpp_map_assert_has_key _cmahk_map _cmahk_key)
    cpp_enable_if_debug()
    cpp_assert_signature("${ARGV}" map str)
    _cpp_map_has_key(_cmahk_has_key "${_cmahk_map}" "${_cmahk_key}")
    cpp_assert("${_cmahk_has_key}" "map contains key '${_cmahk_key}'")
endfunction()
