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
# Defines functions used to manipulate CMakePPLang global variables.
#]]

include_guard()

include(cmakepp_lang/utilities/sanitize_string)

#[[[
# Appends a value to a global list.
#
# When we are manipulating a global state, which is actually a list, we often
# want to append to it and not "set" it (set in this context referring to
# overwriting the value with a new value). This function will append to the
# specified global variable the provided value. If the variable does not exist,
# the variable will be created and initialized to the provided value.
#
# :param key: The name of the global variable to append to. ``key`` is
#             case-insensitive.
# :type key: desc
# :param value: The value to append to ``key``'s current value.
# :type value: str
#
# Error Checking
# ==============
#
# ``cpp_append_global`` will assert that it is called with only two arguments.
#]]
function(cpp_append_global _ag_key _ag_value)
    if(NOT ${ARGC} EQUAL 2)
        message(FATAL_ERROR "cpp_append_global accepts exactly 2 arguments.")
    endif()

    cpp_sanitize_string(_ag_key "${_ag_key}")
    set_property(
        GLOBAL APPEND PROPERTY "__cpp_${_ag_key}_global__" "${_ag_value}"
    )
endfunction()

#[[[
# Sets a global variable to the provided value.
#
# This function will set a global variable to the value provided. If the global
# variable already exists it will overwrite its current value.
#
# :param key: The name of the global variable to set. ``key`` is
#                 case-insensitive.
# :type key: desc
# :param value: The value to set ``key`` to.
# :type value: str
#
# Error Checking
# ==============
#
# ``cpp_set_global`` will assert that it is called with only two arguments.
#]]
function(cpp_set_global _sg_key _sg_value)
    if(NOT ${ARGC} EQUAL 2)
        message(FATAL_ERROR "cpp_set_global accepts exactly 2 arguments.")
    endif()

    cpp_sanitize_string(_sg_key "${_sg_key}")
    set_property(GLOBAL PROPERTY "__cpp_${_sg_key}_global__" "${_sg_value}")
endfunction()

#[[[
# Retrieves the value of the requested global variable.
#
# This function will get the value of the specified global variable. If the
# variable does not exist the empty string will be returned. It is thus not
# possible to discern between an uninitialized global variable and one set to
# the empty string. In practice this is not a problem because global variables
# are not typically set to the empty string.
#
# :param result: Identifier for the variable which after this call will hold
#                    the value stored in global variable ``key``.
# :type value: desc
# :param key: The name of the global variable whose value has been
#                 requested. ``key`` is case-insensitive.
# :type key: desc
# :returns: ``result`` will be set to the value stored in global variable
#           ``key``. If ``key`` has not been set ``result`` will be
#           set to the empty string.
# :rtype: str
#
# Error Checking
# ==============
#
# ``cpp_get_global`` will assert that it is called with only two arguments.
#]]
function(cpp_get_global _gg_result _gg_key)
    if(NOT ${ARGC} EQUAL 2)
        message(FATAL_ERROR "cpp_get_global accepts exactly 2 arguments.")
    endif()

    cpp_sanitize_string(_gg_key "${_gg_key}")
    get_property("${_gg_result}" GLOBAL PROPERTY "__cpp_${_gg_key}_global__")
    set("${_gg_result}" "${${_gg_result}}" PARENT_SCOPE)
endfunction()
