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
include(cmakepp_lang/map/keys)
include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Determines if a map has the specified key.
#
# This function is used to determine if a particular key has been set for this
# map.
#
# :param this: The map for which we want to know if it has the specified
#              key.
# :type this: map
# :param result: Name to use for the variable which will hold the result.
# :type result: desc
# :param key: The key we want to know if the map has.
# :type key: str
# :returns: ``result`` will be set to ``TRUE`` if ``key`` has been
#           set for this map and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was called
# with exactly two arguments, and that those arguments have the correct types.
# If these assertions fail an error will be raised. These checks are only
# performed if CMakePP is run in debug mode.
#]]
function(cpp_map_has_key _mhk_this _mhk_result _mhk_key)
    cpp_assert_signature("${ARGV}" map desc str)

    cpp_map_keys("${_mhk_this}" _mhk_keys)
    list(FIND _mhk_keys "${_mhk_key}" _mhk_index)
    if("${_mhk_index}" GREATER -1)
        set("${_mhk_result}" TRUE PARENT_SCOPE)
    else()
        set("${_mhk_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
