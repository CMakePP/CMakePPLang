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
# Checks if the given name conflicts with any built-in CMakePPLang types.
#
# :param conflict: Return value for whether a conflict exists.
# :type conflict: bool*
# :param conflicting_type: Return value for the type that the name
#                          conflicts with.
# :type conflicting_type: desc*
# :param name: Name to check for conflicts with.
# :type name: desc
#
# :returns: Whether there was a conflict (TRUE) or not (FALSE) and the
#           conflicting type, or an empty string ("") if no conflicts
#           occured.
# :rtype: (bool, desc)
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if it is run in debug mode) this
# function will assert that it was called with all three arguments and that
# the arguments have the correct types.
#]]
function(cpp_check_conflicting_types _cc_conflict _cc_conflicting_type _cc_name)
    cpp_assert_signature("${ARGV}" desc desc desc)

    # This is a list of all of the "built-in" types for CMakePPLang
    set(
        _cc_cpp_types
        bool fxn path float genexpr int list str target desc type class map obj
    )

    # Check if each type matches the given type, which results in a conflict
    foreach(_cc_cpp_type ${_cc_cpp_types})
        if("${_cc_cpp_type}" STREQUAL "${_cc_name}")
            set("${_cc_conflict}" TRUE PARENT_SCOPE)
            set("${_cc_conflicting_type}" "${_cc_cpp_type}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    # No conflict was found
    set("${_cc_conflict}" FALSE PARENT_SCOPE)
    set("${_cc_conflicting_type}" "" PARENT_SCOPE)
endfunction()
