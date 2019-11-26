include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/detail_/has_key)

#[[[ Adds a key to the list of keys a map has.
#
# This function wraps the process of registering a new key with a particular map
# instance. This function in particular adds the key to the list of known keys.
#
# :param _cmak_map: The map to add the key to.
# :type _cmak_map: map
# :param _cmak_key: The key to register with the map.
# :type _cmak_key: str
#
# Example Usage:
# ==============
#
# The following snippet registers the key ``"a_key"`` with the provided map.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/detail_/ctor)
#    include(cmakepp_core/map/detail_/add_key)
#    include(cmakepp_core/map/detail_/has_key)
#    _cpp_map_ctor(a_map)
#    _cpp_map_add_key("${a_map}" "a_key")
#    _cpp_map_has_key(result "${a_map}" a_key)
#    message("The map has the key 'a_key': ${result}")  # Will print TRUE
#
#]]
function(_cpp_map_add_key _cmak_map _cmak_key)
    cpp_assert_signature("${ARGV}" map str)

    string(TOLOWER "${_cmak_key}" _cmak_key)
    _cpp_map_has_key(_cmak_has_key "${_cmak_map}" "${_cmak_key}")
    if(NOT "${_cmak_has_key}")
        set_property(GLOBAL APPEND PROPERTY "${_cmak_map}_keys" "${_cmak_key}")
    endif()
endfunction()
