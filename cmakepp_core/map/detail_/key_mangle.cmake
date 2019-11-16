include_guard()
include(cmakepp_core/asserts/type)

#[[[ Encapsulates the name mangling used for keys.
#
# This function will return the mangled name to use for the provided map
# instance and key. The point of this function is to encapsulate the logic used
# for computing the mangled name.
#
# :param _cmkm_result: The identifier to use for storing the mangled name.
# :type _cmkm_result: desc
# :param _cmkm_map: The map instance the key will be added to.
# :type _cmkm_map: map
# :param _cmkm_key: The key to add.
# :type _cmkm_key: str
# :returns: ``_cmkm_result`` will be set to the mangled name.
# :rtype: desc*
#
# Example Usage:
# ==============
#
# The following code snippet shows how to get the mangled name for a map and
# key pair.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/detail_/ctor)
#    include(cmakepp_core/map/detail_/key_mangle)
#    _cpp_map_ctor(a_map)
#    _cpp_map_key_mangle(result ${a_map} a_key)
#    message("The mangled name is: ${result}")
#
# Although the above code will print a mangled name, developers should not rely
# on this name mangling remaining constant across versions.
#]]
function(_cpp_map_key_mangle _cmkm_result _cmkm_map _cmkm_key)
    cpp_assert_type(desc "${_cmkm_result}" map "${_cmkm_map}")
    set(${_cmkm_result} "${_cmkm_map}_key_${_cmkm_key}" PARENT_SCOPE)
endfunction()
