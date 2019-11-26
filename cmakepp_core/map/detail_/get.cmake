include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/detail_/assert_has_key)
include(cmakepp_core/map/detail_/key_mangle)


#[[[ Retrieves the value of a key.
#
# This function is used to retrieve the value associated with the specified key.
# If the key does not exist, and CMakePP is in debug mode, an error will be
# raised.
#
# :param _cmg_result: The name to use for the variable to hold the result.
# :type _cmg_result: desc
# :param _cmg_map: The map we are retreiving the value from.
# :type _cmg_map: map
# :param _cmg_key: The key whose value is being retrieved.
# :type _cmg_key: str
# :returns: ``_cmg_result`` will be set to the value associated with
#           ``_cmg_key``.
# :rtype: str*
#
# Example Usage:
# ==============
#
# The following code snippet shows how to get the value stored under the key
# ``"foo".
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
function(_cpp_map_get _cmg_result _cmg_map _cmg_key)
    cpp_assert_signature("${ARGV}" desc map str)
    _cpp_map_assert_has_key("${_cmg_map}" "${_cmg_key}")
    _cpp_map_key_mangle(_cmg_key_identifier "${_cmg_map}" "${_cmg_key}")
    get_property("${_cmg_result}" GLOBAL PROPERTY "${_cmg_key_identifier}")
    cpp_return("${_cmg_result}")
endfunction()
