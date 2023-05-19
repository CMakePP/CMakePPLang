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
# Converts the input string into a uniform, filesystem-safe string.
#
# Strings in CMake are case-sensitive in some contexts and case-insensitive in
# others. This function encapsulates the logic for converting a string to a
# common case (currently lower case because most CMake conventions favor it) and
# also replacing potentially troublesome characters in the string. The resulting
# "sanitized" string is suitable for use as a key in a map, part of a variable's
# name, or a C/C++ function name.
#
# :param result: Name for variable which will hold the result.
# :type result: desc
# :param input: The string we are sanitizing.
# :type input: str
# :returns: ``result`` will be set to the sanitized string.
# :rtype: str
#]]
function(cpp_sanitize_string _ss_result _ss_input)
    string(MAKE_C_IDENTIFIER "${_ss_input}" "${_ss_result}")
    string(TOLOWER "${${_ss_result}}" "${_ss_result}")
    set("${_ss_result}" "${${_ss_result}}" PARENT_SCOPE)
endfunction()
