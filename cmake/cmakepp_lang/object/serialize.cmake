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
# Defines functions for serializing and printing a CMakePPLang Object.
#]]

include_guard()

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/serialization/serialization)

#[[[
# Serializes an object into JSON format.
#
# This function is the default implementation for serializing an object. Derived
# classes are free to override it with their own implementations. This
# implementation simply treats the object as a map with a single key-value pair
# comprised of the "this" pointer (as the key) and the serialized state of the
# object as the value.
#
# :param this: The object we are serializing.
# :type this: obj
# :param result: Name for the identifier which will hold the serialized
#                value.
# :type result: desc
# :returns: ``result`` will be set to the JSON serialized representation of
#           ``this``.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is) this function will assert
# that the caller has provided exactly two arguments and that those arguments
# have the correct types. If any assertion fails an error is raised.
#]]
function(_cpp_object_serialize _os_this _os_result)
    cpp_assert_signature("${ARGV}" obj desc)

    cpp_get_global(_os_state "${_os_this}__state")
    set(_os_temp "{ \"${_os_this}\" :")
    _cpp_serialize_map(_os_buffer "${_os_state}")
    string(APPEND _os_temp " ${_os_buffer} }")
    set("${_os_result}" "${_os_temp}" PARENT_SCOPE)
endfunction()

#[[[
# Prints an object to standard out.
#
# This function is code factorization for serializing an object and printing the
# serialized form to standard out.
#
# :param this: The object we are printing to standard out.
# :type this: obj
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is) this function will ensure
# that it was called with a single argument and that the argument is implicitly
# convertible to an Object. If either of these assertions fail an error will be
# raised.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#]]
function(_cpp_object_print _op_this)
    cpp_assert_signature("${ARGV}" obj)

    _cpp_object_serialize("${_op_this}" _op_result)
    message("${_op_result}")
endfunction()
