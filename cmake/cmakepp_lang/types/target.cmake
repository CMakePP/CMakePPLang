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
# Determines if a string is the name of a target.
#
# CMake maintains an internal list of targets and allows us to query whether a
# particular identifier is a target via CMake's native ``if`` statement. This
# function simply wraps a call to ``if(TARGET ...)``.
#
# :param return: Name to use for the resulting identifier.
# :type return: desc
# :param str2check: The string whose targety-ness is in question
# :type str2check: str
# :returns: ``return`` will be set to ``TRUE`` if ``str2check`` is a
#           target and ``FALSE`` otherwise.
# :rtype: bool
#
# Example Usage
# =============
#
# The following is an example showcasing how one would check if the identifier
# ``my_target`` is a target:
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/types/target)
#    add_library(my_target STATIC IMPORTED)
#    cpp_is_target(return ${my_target})
#    message("my_target is a target: ${return}")  # prints TRUE
#
# Error Checking
# ==============
#
# ``cpp_is_target`` will assert that the caller has provided exactly two
# arguments. If this is not the case an error will be raised.
#]]
function(cpp_is_target _it_return _it_str2check)
    if(NOT "${ARGC}" EQUAL 2)
        message(FATAL_ERROR "cpp_is_target takes exactly 2 arguments.")
    endif()

    if(TARGET "${_it_str2check}")
        set("${_it_return}" TRUE PARENT_SCOPE)
    else()
        set("${_it_return}" FALSE PARENT_SCOPE)
    endif()
endfunction()
