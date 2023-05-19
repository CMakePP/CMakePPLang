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
include(cmakepp_lang/utilities/return)

#[[[
# Registers a class constructor.
#
# This function is used to declare a class constructor.
#
# :param name: The name of the constructor (CTOR by convention). This will be
#                 the named used to invoke the member constructor.
# :type name: desc
# :param type: The class we are adding the constructor to.
# :type type: class
# :param \*args: The types of the arguments to the constructor function.
# :returns: ``_c_name`` will be set to the mangled name of the declared
#            constructor to facilitate implementing it.
# :rtype: desc
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
function(cpp_constructor _c_name _c_type)
    cpp_assert_signature("${ARGV}" desc class args)

    cpp_get_global(_c_state "${_c_type}__state")
    _cpp_object_add_fxn("${_c_state}" "${_c_name}" "desc" ${ARGN})
    cpp_return("${_c_name}")
endfunction()
