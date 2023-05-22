# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#[[[ @module
# Defines functions to get and set key/value pairs for a CMakePPLang Map.
#]]

include_guard()

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)

#[[[
# Retrieves the value of the specified key.
#
# This function is used to retrieve the value associated with the provided key.
# If a key has not been set this function will return the empty string. Users
# can use ``cpp_map_has_key`` to determine whether the map does not have the
# key or if the key was simply set to the empty string.
#
# :param this: The map storing the key-value pairs.
# :type this: map
# :param value: Name for the identifier to save the value to.
# :type value: desc
# :param key: The key whose value we want.
# :type key: str
# :returns: ``value`` will be set to the value associated with ``key``.
#           If ``key`` has no value associated with it ``value`` will be
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
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(cpp_map_get _mg_this _mg_value _mg_key)
    cpp_assert_signature("${ARGV}" map desc str)

    cpp_get_global("${_mg_value}" "${_mg_this}_keys_${_mg_key}")
    cpp_return("${_mg_value}")
endfunction()

#[[[
# Associates a value with the specified key.
#
# This function can be used to set the value of a map's key. If the key has a
# value associated with it already that value will be overridden.
#
# :param this: The map whose key is going to be set.
# :type this: map
# :param key: The key whose value is going to be set.
# :type key: str
# :param value: The value to set the key to.
# :type value: str
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly three arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
#]]
function(cpp_map_set _ms_this _ms_key _ms_value)
    cpp_assert_signature("${ARGV}" map str str args)

    cpp_append_global("${_ms_this}_keys" "${_ms_key}")
    cpp_set_global("${_ms_this}_keys_${_ms_key}" "${_ms_value}")

    if("${ARGC}" GREATER 3)
        cpp_map_set("${_ms_this}" ${ARGN})
    endif()
endfunction()
