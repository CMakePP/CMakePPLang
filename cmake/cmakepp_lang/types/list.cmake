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

#[[[
# Determines if a string is lexically convertible to a CMake list.
#
# CMake lists are strings that contain semicolons. While CMake's list command
# will treat a string without a semicolon as a list with one element, for the
# purposes of determining if a string is a list we require that the list has at
# least two elements (*i.e.*, there must be a semicolon in it). This function
# determines if the provided string meets this definition of a list.
#
# :param result: Used as the name of the returned identifier.
# :type result: desc
# :param str2check: The string whose listy-ness is being questioned.
# :type str2check: str
# :returns: ``result`` will be set to ``TRUE`` if ``str2check`` is a
#           list and ``FALSE`` otherwise.
# :rtype: bool
#
# Example Usage
# =============
#
# The following snippet shows how to determine if a variable contains a list.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/list)
#    set(a_list 1 2 3)
#    cpp_is_list(result "${a_list}")
#    message("Is a list: ${result}")  # Will print TRUE
#
# Error Checking
# ==============
#
# ``cpp_is_list`` will assert that the caller has provided exactly two
# arguments. If the caller has provided a different number of arguments than an
# error will be raised.
#]]
function(cpp_is_list _il_result _il_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_list takes exactly 2 arguments.")
    endif()

    list(LENGTH _il_str2check _il_length)
    if("${_il_length}" GREATER 1)
        set("${_il_result}" TRUE PARENT_SCOPE)
    else()
        set("${_il_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
