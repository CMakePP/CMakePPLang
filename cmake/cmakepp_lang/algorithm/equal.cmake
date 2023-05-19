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
include(cmakepp_lang/map/equal)
include(cmakepp_lang/object/equal)
include(cmakepp_lang/types/type_of)
include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/utilities/compare_lists)
include(cmakepp_lang/utilities/return)

#[[[
# Compares two values for equivalency.
#
# This function can be used to compare any two CMakePP objects for equality. For
# native CMake types, like booleans and integers, equality is defined as being
# the same string. ``cpp_equal`` will also compare objects like CMakePP maps or
# instances of user-defined classes to ensure they have the same state. If two
# objects have different types they are defined to be unequal.
#
# :param result: The name to use for variable holding the result.
# :type result: desc
# :param lhs: One of the two values involved in the comparison.
# :type lhs: str
# :param rhs: The other value involved in the comparison
# :type rhs: str
# :returns: ``result`` will be set to ``TRUE`` if ``lhs`` compares equal
#           to ``rhs`` and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will assert that it is
# being called with exactly three arguments and that those arguments are of the
# correct types. If any of these asserts fail an error will be raised. These
# errors are only checked for in debug mode.
#]]
function(cpp_equal _e_result _e_lhs _e_rhs)
    cpp_assert_signature("${ARGV}" desc str str)
    
    cpp_type_of(_e_lhs_type "${_e_lhs}")
    cpp_type_of(_e_rhs_type "${_e_rhs}")
    cpp_implicitly_convertible(
        _e_good_types "${_e_rhs_type}" "${_e_lhs_type}"
    )

    # Different types
    if(NOT "${_e_good_types}")
        set("${_e_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    cpp_implicitly_convertible(_e_is_obj "${_e_lhs_type}" "obj")
    if("${_e_is_obj}")
        _cpp_object_equal("${_e_lhs}" "${_e_result}" "${_e_rhs}")
        cpp_return("${_e_result}")
    elseif("${_e_lhs_type}" STREQUAL "list")
        cpp_compare_lists("${_e_result}" _e_lhs _e_rhs)
        cpp_return("${_e_result}")
    elseif("${_e_lhs_type}" STREQUAL "map")
        cpp_map(EQUAL "${_e_lhs}" "${_e_result}" "${_e_rhs}")
        cpp_return("${_e_result}")
    elseif("${_e_lhs}" STREQUAL "${_e_rhs}")
        set("${_e_result}" TRUE PARENT_SCOPE)
    else()
        set("${_e_result}" FALSE PARENT_SCOPE)
    endif()
endfunction()
