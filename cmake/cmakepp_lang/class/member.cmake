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
# Registers a class's member function.
#
# This function is used to declare a new member function.
#
# :param name: The name of the member function. This is the name you will use
#                 to invoke the member function.
# :type name: desc
# :param type: The class we are adding the member function to. This is also
#                 the type of the "this" pointer.
# :type type: class
# :param \*args: The types of the arguments to the member function. This list
#               should NOT include the type for the this pointer as this will
#               automatically be prepended to this list.
# :returns: ``_m_name`` will be set to the mangled name of the declared
#            function to facilitate implementing it.
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
function(cpp_member _m_name _m_type)
    cpp_assert_signature("${ARGV}" desc class args)

    cpp_get_global(_m_state "${_m_type}__state")
    _cpp_object_add_fxn("${_m_state}" "${_m_name}" "${_m_type}" ${ARGN})
    cpp_return("${_m_name}")
endfunction()
