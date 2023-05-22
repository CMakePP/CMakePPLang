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
# Defines functions for manipulating a CMakePPLang object's type.
#]]

include_guard()

include(cmakepp_lang/utilities/global)

#[[[
# Encapsulates the process of getting a CMakePP object's type.
#
# CMakePP introduces several additional built-in types as well as the ability
# for users to define their own types. This function encapsulates the logic
# to determine if an object is a CMakePP type, and if it is, how to determine
# that type.
#
# :param is_cpp_obj: Identifier for the variable which will hold whether or
#                    not ``obj`` is a CMakePP object.
# :type is_cpp_obj: desc
# :param type: Identifier to hold the type of ``obj`` if it is indeed
#              a CMakePP object.
# :type type: desc
# :param obj: The object for which we want to know if it is a CMakePP
#             object, and if it is, what is its type.
# :type obj: str
#
# :returns: ``is_cpp_obj`` will be set to ``TRUE`` if ``obj`` is a
#           CMakePP built-in type or a user-defined type and ``FALSE``
#           otherwise. If ``is_cpp_obj`` is ``TRUE`` than ``type``
#           will be set to the type of ``obj``. If ``is_cpp_obj`` is
#           ``FALSE`` than ``type`` will be set to the empty string.
# :rtype: (bool, type) or (bool, desc)
#
# .. note::
#
#    This function is used as part of the type-checking machinery and can not
#    rely on ``cpp_assert_signature`` to check its input types. It is a macro to
#    avoid the need to call ``cpp_return`` to forward the return.
#
# Error Checking
# ==============
#
# ``_cpp_get_cmakepp_type`` will ensure that it was provided three arguments. If
# it was not provided exactly three arguments an error will be raised.
#
#]]
macro(_cpp_get_cmakepp_type _gct_is_cpp_obj _gct_type _gct_obj)
    if(NOT "${ARGC}" EQUAL 3)
        message(FATAL_ERROR "_cpp_get_cmakepp_type takes exactly 3 arguments.")
    endif()

    cpp_get_global("${_gct_type}" "${_gct_obj}__type")
    if("${${_gct_type}}" STREQUAL "")
        set("${_gct_is_cpp_obj}" FALSE)
    else()
        set("${_gct_is_cpp_obj}" TRUE)
    endif()
endmacro()

#[[[
# Encapsulates the process of setting a CMakePP object's type.
#
# CMakePP introduces several additional built-in types as well as the ability
# for users to define their own types. This function encapsulates the logic
# for setting a CMakePP object's type.
#
# .. note::
#
#   That before calling this function the "this"-pointer will simply be a
#   description. It is this function which makes the CMakePP runtime recognize
#   the "this"-pointer as actually-being of the specified type.
#
# :param this: The "this"-pointer for the CMakePP object we are setting the
#                   type of.
# :type this: desc
# :param type: The type we are making ``this``.
# :type type: type
#
# Error Checking
# ==============
#
# ``_cpp_set_cmakepp_type`` will assert that it is called with exactly two
# arguments, and if it is not, will raise an error.
#]]
function(_cpp_set_cmakepp_type _sct_this _sct_type)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "_cpp_set_cmakepp_type takes exactly 2 arguments.")
    endif()

    cpp_set_global("${_sct_this}__type" "${_sct_type}")
endfunction()
