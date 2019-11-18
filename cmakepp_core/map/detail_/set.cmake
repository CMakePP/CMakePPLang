include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/detail_/add_key)
include(cmakepp_core/map/detail_/key_mangle)

#[[[ Code factorization for set and append
#
# The CMakePP map functions ``set`` and ``append`` only differ in the mode they
# run ``set_property`` in. This function factors out the common implementation.
#
# :param _cmsg_mode: Which mode should ``set_property`` be run in? If
#                    ``_cmsg_mode`` is ``APPEND``, ``set_property`` will be run
#                    in append mode.
# :type _cmsg_mode: desc
# :param _cmsg_map: The map we are setting/appending a value to.
# :type _cmsg_map: map
# :param _cmsg_key: The key we are storing the value under.
# :type _cmsg_key: desc
# :param _cmsg_value: The value to set/append under the key.
# :type _cmsg_value: str
#]]
function(_cpp_map_set_guts _cmsg_mode _cmsg_map _cmsg_key _cmsg_value)
    cpp_assert_type(map "${_cmsg_map}" desc "${_cmsg_key}")
    _cpp_map_add_key("${_cmsg_map}" "${_cmsg_key}")
    _cpp_map_key_mangle(_cmsg_key_identifier "${_cmsg_map}" "${_cmsg_key}")
    if("${_cmsg_mode}" STREQUAL "APPEND")
        set_property(
            GLOBAL APPEND PROPERTY "${_cmsg_key_identifier}" "${_cmsg_value}"
        )
    else()
        set_property(
                GLOBAL PROPERTY "${_cmsg_key_identifier}" "${_cmsg_value}"
        )
    endif()
endfunction()

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
    _cpp_map_set_guts("" "${_cms_map}" "${_cms_key}" "${_cms_value}")
endfunction()

#[[[ Appends (and possibly adds) a key to the specified value
#
# This function is used to append a value to the value stored under a map's key.
# If the key does not exist, the key will first be added to the map and then
# set. If the key exists, the provided value will be appended to the value.
#
# :param _cma_map: The map we are modifying.
# :type _cma_map: map
# :param _cma_key: The key we are appending the value to.
# :type _cma_key: desc
# :param _cma_value: The value we are appending to the key's value.
# :type _cma_value: str
#
# Example Usage:
# ==============
#
# The following code snippet shows how to append the key ``"foo"`` to ``"bar"``.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/map/detail_/ctor)
#    include(cmakepp_core/map/detail_/get)
#    include(cmakepp_core/map/detail_/set)
#    _cpp_map_ctor(a_map)
#    _cpp_map_append("${a_map}" foo bar)
#    _cpp_map_get(value "${a_map}" foo)
#    message("The value of 'foo' is: ${value}")  # Prints "bar"
#]]
function(_cpp_map_append _cma_map _cma_key _cma_value)
    _cpp_map_set_guts(APPEND "${_cma_map}" "${_cma_key}" "${_cma_value}")
endfunction()
