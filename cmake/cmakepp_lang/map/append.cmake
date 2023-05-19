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

#[[[
# Appends to the value stored under the specified key.
#
# This member function will append the provided value to the list stored under
# the specified key. If the key does not exist, a list will be started with the
# provided value and stored under the specified key.
#
# :param this: The map we modifying the state of.
# :type this: map
# :param key: The key whose value is being appended to.
# :type key: str
# :param value: Value we are appending to the list stored under ``_ma_key``.
# :type value: str
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode, this function will assert that it is called
# with the correct number of arguments and that each argument has the correct
# type. If an assert fails an error will be raised. The assertions happen only
# when CMakePP is run in debug mode.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
#]]
function(cpp_map_append _ma_this _ma_key _ma_value)
    cpp_assert_signature("${ARGV}" map str str)

    cpp_append_global("${_ma_this}_keys" "${_ma_key}")
    cpp_append_global("${_ma_this}_keys_${_ma_key}" "${_ma_value}")
endfunction()
