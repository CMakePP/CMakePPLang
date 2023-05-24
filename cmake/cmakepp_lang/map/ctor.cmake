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

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/utilities/global)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/unique_id)

#[[[
# Constructs a new Map instance with the specified state (if provided)
#
# This function creates a new Map instance. The caller may provided one or more
# pairs of input to be used as the initial state. If provided, the pairs are
# assumed to be such that the first value is the key and the second value is the
# value to associate with that key. If no key-value pairs are provided the
# resulting map will be empty.
#
# :param result: Name for variable which will hold the new map.
# :type result: desc
# :param \*args: A list whose elements will be considered pairwise to be the
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
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
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
