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

#[[[
# Gets a list of all keys known to a map.
#
# This function can be used to get a list of keys which have been set for this
# map.
#
# :param this: The map whose keys are being retrieved.
# :type this: map
# :param keys: Name for the variable which will hold the keys.
# :type keys: desc
# :returns: ``keys`` will be set to the list of keys which have been set for
#           ``this``.
# :rtype: [desc]
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
function(cpp_map_keys _mk_this _mk_keys)
    cpp_assert_signature("${ARGV}" map desc)

    cpp_get_global("${_mk_keys}" "${_mk_this}_keys")
    list(REMOVE_DUPLICATES "${_mk_keys}")
    cpp_return("${_mk_keys}")
endfunction()
