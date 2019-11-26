include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Retrieves a list of the keys which have been set for the current map.
#
# This function encapsulates the process of retrieving the list of keys that
# have been set for the map.
#
# :param _cmk_result: The name to use for the variable to hold the result.
# :type _cmk_result: desc
# :param _cmk_map: The map whose keys we want.
# :type _cmk_map: map
# :returns: ``_cmk_result`` will be set to the list of keys the map has.
# :rtype: list
#
# Example Usage:
# ==============
#
# The following snippet retrieves the list of keys associated with the map.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/detail_/add_key)
#    include(cmakepp_core/map/detail_/ctor)
#    _cpp_map_ctor(a_map)
#    _cpp_map_add_key("${a_map}" a_key)
#    _cpp_map_add_key("${a_map}" another_key)
#    _cpp_map_keys(result "${a_map}")
#    message("The maps keys are: ${result}")  # Prints "a_key;another_key"
#]]
function(_cpp_map_keys _cmk_result _cmk_map)
    cpp_assert_signature("${ARGV}" desc map)
    get_property("${_cmk_result}" GLOBAL PROPERTY "${_cmk_map}_keys")
    cpp_return("${_cmk_result}")
endfunction()
