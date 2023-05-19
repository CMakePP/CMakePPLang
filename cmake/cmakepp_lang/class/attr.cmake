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
include(cmakepp_lang/object/object)
include(cmakepp_lang/utilities/global)

#[[[
# Registers a class's attribute.
#
# This function is used to declare a new attribute for a class.
#
# :param type: The name of the class getting the attribute.
# :type type: class
# :param attr: The name of the attribute
# :type attr: desc
# :param \*args: The initial value of the attribute. If no ``*args`` are provided
#               the attribute will be initialized to the empty string.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if) this function will assert that
# it is called with the correct number and types of arguments. If any of these
# assertions fail an error will be raised.
#]]
function(cpp_attr _a_type _a_attr)
    cpp_assert_signature("${ARGV}" class desc args)

    cpp_get_global(_a_state "${_a_type}__state")
    _cpp_object_set_attr("${_a_state}" "${_a_attr}" "${ARGN}")
endfunction()
