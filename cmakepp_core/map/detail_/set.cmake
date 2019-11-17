include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/detail_/add_key)
include(cmakepp_core/map/detail_/key_mangle)

#[[[ Sets (and possibly adds) a key to the specified value
#
# This function is used to set a map's key to the provided value. If the key
# does not exist, the key will first be added to the map and then set. If the
# key exists, its contents will be overwritten.
#
# :param _cms_map: The map we are setting the key in.
# :type _cms_map: map
# :param _cms_key: The key we are setting the value of.
# :type _cms_key: desc
# :param _cms_value: The value we are setting the key to.
# :type _cms_value: str
#
# Example Usage:
# ==============
#
# The following code snippet shows how to set the key ``"foo"`` to ``"bar"``.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/detail_/ctor)
#    include(cmakepp_core/map/detail_/get)
#    include(cmakepp_core/map/detail_/set)
#    _cpp_map_ctor(a_map)
#    _cpp_map_set("${a_map}" foo bar)
#    _cpp_map_get(value "${a_map}" foo)
#    message("The value of 'foo' is: ${value}")  # Prints "bar"
#]]
function(_cpp_map_set _cms_map _cms_key _cms_value)
    cpp_assert_type(map "${_cms_map}" desc "${_cms_key}")
    _cpp_map_add_key("${_cms_map}" "${_cms_key}")
    _cpp_map_key_mangle(_cms_key_identifier "${_cms_map}" "${_cms_key}")
    set_property(GLOBAL PROPERTY "${_cms_key_identifier}" "${_cms_value}")
endfunction()
