include_guard()
include(cmakepp_core/algorithm/copy)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/get)
include(cmakepp_core/map/detail_/keys)
include(cmakepp_core/map/detail_/set)

#[[[ Merges ``_cmm_rhs`` into ``_cmm_lhs``.
#
# This function adds the (key,value)-pairs from ``_cmm_rhs`` into the map
# ``_cmm_lhs`` overwriting values associated with common keys. In other words
# if both maps have a key ``common_key``, which in ``_cmm_lhs`` is associated
# with a value ``lhs`` and in ``_cmm_rhs`` is associated with a value ``rhs``,
# then after this operation ``_cmm_lhs`` will still have a key ``common_key``,
# but its value will now be ``rhs``.
#
# :param _cmm_lhs: The map we are merging ``_cmm_rhs`` into.
# :type _cmm_lhs: map
# :param _cmm_rhs: The map we are merging into ``_cmm_lhs``.
# :type _cmm_rhs: map
#
#]]
function(_cpp_map_merge _cmm_lhs _cmm_rhs)
    cpp_assert_signature("${ARGV}" map map)

    _cpp_map_keys(_cmm_keys "${_cmm_rhs}")
    foreach(_cmm_key_i ${_cmm_keys})
        _cpp_map_get(_cmm_value_i "${_cmm_rhs}" "${_cmm_key_i}")
        cpp_copy(_cmm_copy "${_cmm_value_i}")
        _cpp_map_set("${_cmm_lhs}" "${_cmm_key_i}" "${_cmm_copy}")
    endforeach()
endfunction()
