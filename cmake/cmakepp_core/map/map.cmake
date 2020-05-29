include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/copy)
include(cmakepp_core/map/equal)
include(cmakepp_core/map/has_key)
include(cmakepp_core/map/keys)
include(cmakepp_core/map/merge)
include(cmakepp_core/map/remove)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/unique_id)

#[[[ Appends to the value stored under the specified key.
#
# This member function will append the provided value to the list stored under
# the specified key. If the key does not exist, a list will be started with the
# provided value and stored under the specified key.
#
# :param _ma_this: The map we modifying the state of.
# :type _ma_this: map
# :param _ma_key: The key whose value is being appended to.
# :type _ma_key: str
# :param _ma_value: Value we are appending to the list stored under ``_ma_key``.
# :type _ma_value: str
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode, this function will assert that it is called
# with the correct number of arguments and that each argument has the correct
# type. If an assert fails an error will be raised. The assertions happen only
# when CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#
#]]
function(cpp_map_append _ma_this _ma_key _ma_value)
    cpp_assert_signature("${ARGV}" map str str)

    cpp_append_global("${_ma_this}_keys" "${_ma_key}")
    cpp_append_global("${_ma_this}_${_ma_key}" "${_ma_value}")
endfunction()

#[[[ Constructs a new Map instance with the specified state (if provided)
#
# This function creates a new Map instance. The caller may provided one or more
# pairs of input to be used as the initial state. If provided, the pairs are
# assumed to be such that the first value is the key and the second value is the
# value to associate with that key. If no key-value pairs are provided the
# resulting map will be empty.
#
# :param _mc_result: Name for variable which will hold the new map.
# :type _mc_result: desc
# :param *args: A list whose elements will be considered pairwise to be the
#               initial key-value pairs populating the map.
# :returns: ``_mc_result`` will be set to the newly created Map instance.
# :rtype: map
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it has been
# called with at least one argument, that this argument is of type ``desc``,
# and that any additional arguments are of type ``(desc, str)``. If any of these
# assertions fail an error will be raised. These assertions are only performed
# if CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_map_ctor _mc_result)
    cpp_assert_signature("${ARGV}" desc args)

    # "Allocate" the new instance and set its type
    cpp_unique_id("${_mc_result}")
    cpp_set_global("${${_mc_result}}__type" map)

    # If variadic, the additional arguments are the initial state so call "set"
    if("${ARGC}" GREATER 1)
        cpp_map_set("${${_mc_result}}" ${ARGN})
    endif()

    cpp_return("${_mc_result}")
endfunction()

#[[[ Retrieves the value of the specified key.
#
# This function is used to retrieve the value associated with the provided key.
# If a key has not been set this function will return the empty string. Users
# can use ``cpp_map_has_key`` to determine whether the map does not have the
# key or if the key was simply set to the empty string.
#
# :param _mg_this: The map storing the key-value pairs.
# :type _mg_this: map
# :param _mg_value: Name for the identifier to save the value to.
# :type _mg_value: desc
# :param _mg_key: The key whose value we want.
# :type _mg_key: str
# :returns: ``_mg_value`` will be set to the value associated with ``_mg_key``.
#           If ``_mg_key`` has no value associated with it ``_mg_value`` will be
#           set to the empty string.
# :rtype: str
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that it has been
# provided exactly three arguments and that those arguments are of the correct
# types. If any of these checks fail an error will be raised. These checks are
# only performed if CMakePP is being run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#]]
function(cpp_map_get _mg_this _mg_value _mg_key)
    cpp_assert_signature("${ARGV}" map desc str)

    cpp_get_global("${_mg_value}" "${_mg_this}_${_mg_key}")
    cpp_return("${_mg_value}")
endfunction()

#[[[ Associates a value with the specified key.
#
# This function can be used to set the value of a map's key. If the key has a
# value associated with it already that value will be overridden.
#
# :param _ms_this: The map whose key is going to be set.
# :type _ms_this: map
# :param _ms_key: The key whose value is going to be set.
# :type _ms_key: str
# :param _ms_value: The value to set the key to.
# :type _ms_value: str
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly three arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#
#]]
function(cpp_map_set _ms_this _ms_key _ms_value)
    cpp_assert_signature("${ARGV}" map str str args)

    cpp_append_global("${_ms_this}_keys" "${_ms_key}")
    cpp_set_global("${_ms_this}_${_ms_key}" "${_ms_value}")

    if("${ARGC}" GREATER 3)
        cpp_map_set("${_ms_this}" ${ARGN})
    endif()
endfunction()

#[[[ Public API for interacting with Map instances.
#
#
# :param _m_mode: The name of the member function to call.
# :type _m_mode: desc
# :param _m_this: The Map instance the member function is being called on.
# :type _m_this: map
# :param *args: Any additional arguments required by the specified member
#               function.
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode, the individual member functions will
# ensure that they have been called with correct number of, and types of,
# arguments. In the event that the incorrect number or types of arguments have
# been provided an error will be raised. These error checks are only done when
# CMakePP is run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is b
#]]
function(cpp_map _m_mode _m_this)
    string(TOLOWER "${_m_mode}" _m_lc_mode)

    if("${_m_lc_mode}" STREQUAL "append")
        cpp_map_append("${_m_this}" "${ARGV2}" "${ARGV3}")
    elseif("${_m_lc_mode}" STREQUAL "copy")
        cpp_map_copy("${_m_this}" "${ARGV2}")
        cpp_return("${ARGV2}")
    elseif("${_m_lc_mode}" STREQUAL "ctor")
        cpp_map_ctor("${_m_this}" ${ARGN})
        cpp_return("${_m_this}")
    elseif("${_m_lc_mode}" STREQUAL "equal")
        cpp_map_equal("${_m_this}" "${ARGV2}" "${ARGV3}")
        cpp_return("${ARGV2}")
    elseif("${_m_lc_mode}" STREQUAL "get")
        cpp_map_get("${_m_this}" "${ARGV2}" "${ARGV3}")
        cpp_return("${ARGV2}")
    elseif("${_m_lc_mode}" STREQUAL "has_key")
        cpp_map_has_key("${_m_this}" "${ARGV2}" "${ARGV3}")
        cpp_return("${ARGV2}")
    elseif("${_m_lc_mode}" STREQUAL "keys")
        cpp_map_keys("${_m_this}" "${ARGV2}")
        cpp_return("${ARGV2}")
    elseif("${_m_lc_mode}" STREQUAL "set")
        cpp_map_set("${_m_this}" "${ARGV2}" "${ARGV3}")
    elseif("${_m_lc_mode}" STREQUAL "remove")
        cpp_map_remove("${_m_this}" "${ARGN}")
    elseif("${_m_lc_mode}" STREQUAL "update")
        cpp_map_update("${_m_this}" "${ARGV2}")
    else()
        message(
            FATAL_ERROR "Map member function map::${_m_lc_mode} does not exist"
        )
    endif()
endfunction()
