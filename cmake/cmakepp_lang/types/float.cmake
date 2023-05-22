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
# Determines if a string can be lexically cast to a float.
#
# For our purposes a float is any string whose only characters include a decimal
# point, and the numbers 0 through 9. Optionally the float may be prefixed with
# a minus sign.
#
# :param return: Name for the variable used to store the result.
# :type return: desc
# :param str2check: The string we are checking for its floaty-ness
# :type str2check: str
# :returns: ``return`` will be set to ``TRUE`` if ``str2check`` is a
#           float and ``FALSE`` otherwise.
# :rtype: bool
#
# Example Usage
# =============
#
# The following is an example showcasing how one would check if the identifier
# ``x`` contained a float.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/float)
#    set(x 3.14)
#    cpp_is_float(return ${x})
#    message("3.14 is a float: ${return}")  # prints TRUE
# 
# Error Checking
# ==============
#
# ``cpp_is_float`` will assert that it is called with exactly two arguments. If
# it is not an error will be raised.
#]]
function(cpp_is_float _if_return _if_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_float accepts exactly 2 arguments")
    endif()

    # Note: Regex pattern strings in CMake require 2 backslashes to escape
    # characters (must escape CMake string first)
    string(REGEX MATCH "^-?[0-9]+\\.[0-9]+\$" _if_match "${_if_str2check}")

    if("${_if_match}" STREQUAL "")
        set(${_if_return} FALSE PARENT_SCOPE)
    else()
        set(${_if_return} TRUE PARENT_SCOPE)
    endif()
endfunction()
