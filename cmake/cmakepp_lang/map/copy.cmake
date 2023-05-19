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
# Makes a deep copy of a Map instance.
#
# This function will deep copy (recursively) the contents of a map into a new
# Map instance. The resulting instance will not alias the original map in any
# way.
#
# :param this: The Map instance being copied.
# :type this: map
# :param other: The name of the variable which will hold the deep copy.
# :type other: desc
# :returns: ``other`` will be set to a deep copy of ``this``.
# :rtype: map
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_map_copy`` will ensure that the caller
# has provided only two arguments and that those arguments are of the correct
# types. This error check is only performed if CMakePP is being run in debug
# mode.
#]]
function(cpp_map_copy _mc_this _mc_other)
    cpp_assert_signature("${ARGV}" map desc)

    # Start a local buffer to avoid recursive calls overwriting our progress
    cpp_map_ctor("_mc_temp")

    # Get and loop over the keys
    cpp_map_keys("${_mc_this}" _mc_keys)
    foreach(_mc_key_i IN LISTS _mc_keys)

        # Get the i-th value from this map, copy it, and put it into the copy
        cpp_map_get("${_mc_this}" _mc_value_i "${_mc_key_i}")
        cpp_copy(_mc_value_copy "${_mc_value_i}")
        cpp_map_set("${_mc_temp}" "${_mc_key_i}" "${_mc_value_copy}")
    endforeach()

    # Done copying this map so return the buffer as the copy
    set("${_mc_other}" "${_mc_temp}" PARENT_SCOPE)
endfunction()
