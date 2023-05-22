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
# Determines if a string can lexically be cast to an integer.
#
# For our purposes an integer is any string whose only characters are taken from
# the numbers 0 through 9, optionally prefixed with a ``-`` sign. In particular,
# this means that strings like ``" 2"`` are not recognized as integers by this
# function (note the space in ``" 2"``).
#
# :param return: The name to use for the variable holding the result.
# :type return: desc
# :param str2check: The string which may be an integer.
# :type str2check: str
# :returns: ``return`` will be set to ``TRUE`` if ``str2check`` is an
#           integer and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# ``cpp_is_int`` will ensure that the caller has provided exactly two arguments.
# If the caller has provided a different amount of arguments this function will
# raise an error.
#]]
function(cpp_is_int _ii_return _ii_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_int takes exactly 2 arguments.")
    endif()

    string(REGEX MATCH "^-?[0-9]+\$" _ii_match "${_ii_str2check}")
    if("${_ii_match}" STREQUAL "")
        set("${_ii_return}" FALSE PARENT_SCOPE)
    else()
        set("${_ii_return}" TRUE PARENT_SCOPE)
    endif()
endfunction()
