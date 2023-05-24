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
# Provides an easy way for the user to include the various functions used 
# to create and maintain an instance of a CMakePPLang map.
#]]

include_guard()
include(cmakepp_lang/map/append)
include(cmakepp_lang/map/copy)
include(cmakepp_lang/map/ctor)
include(cmakepp_lang/map/equal)
include(cmakepp_lang/map/get_set)
include(cmakepp_lang/map/has_key)
include(cmakepp_lang/map/keys)
include(cmakepp_lang/map/merge)
include(cmakepp_lang/map/remove)
include(cmakepp_lang/utilities/return)

#[[[
# Public API for interacting with Map instances.
#
# :param mode: The name of the member function to call.
# :type mode: desc
# :param this: The Map instance the member function is being called on.
# :type this: map
# :param \*args: Any additional arguments required by the specified member
#               function.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode, the individual member functions will
# ensure that they have been called with correct number of, and types of,
# arguments. In the event that the incorrect number or types of arguments have
# been provided an error will be raised. These error checks are only done when
# CMakePP is run in debug mode.
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
