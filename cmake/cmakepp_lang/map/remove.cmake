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

include_guard()

include(cmakepp_lang/algorithm/copy)
include(cmakepp_lang/asserts/signature)

#[[[
# Removes the specified keys from a map.
#
# This function removes the key-value pairs for specified keys from a map.
#
# :param this: The map that will have key-value pairs removed from it
# :type this: map
# :param \*args: The keys to remove from _r_this.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that the first
# argument passed to this function was a map. If this assertion fails an error
# will be raised. These checks are only performed if CMakePP is run in debug
# mode.
#]]
function(cpp_map_remove _r_this)
    cpp_assert_signature("${ARGV}" map args)

    # Remove each key from the map
    foreach(_r_key ${ARGN})
        # If the key doesn't exist in the map, do nothing
        cpp_map(HAS_KEY "${_r_this}" _r_this_has_key "${_r_key}")
        if(NOT "${_r_this_has_key}")
            continue()
        endif()

        # Remove the value for the key
        cpp_set_global("${_r_this}_${_r_key}" "")

        # Remove the key from the list of keys
        cpp_get_global(_r_this_keys "${_r_this}_keys")
        list(REMOVE_ITEM _r_this_keys "${_r_key}")
        cpp_set_global("${_r_this}_keys" "${_r_this_keys}")
    endforeach()
endfunction()
