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

include(cmakepp_lang/algorithm/equal)
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/utilities/return)

#[[[
# Encapsulates the process of comparing two CMake lists to one another.
#
# Two CMake lists are equal if they contain the same number of elements and if
# the :math:`i`-th element in ``lhs`` compares equal to the :math:`i`-th
# element of ``rhs`` under ``cpp_equal`` for all elements in the list. In
# particular this means that the lists must have the same order and that we
# compare the values of CMakePP objects, not their this-pointers.
#
# :param result: Name for variable which will hold the result.
# :type result: desc
# :param lhs: Identifier containing the first list to compare.
# :type lhs: list*
# :param rhs: Identifier containing the second list to comapre.
# :type rhs: list*
# :returns: ``result`` will be set to ``TRUE`` if the two lists are equal
#           and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode, this function will assert that the function
# is only provided three arguments (preventing the user from accidentally
# dereferencing one of the input lists in most cases) and that the arguments are
# all of type ``desc``.
#]]
function(cpp_compare_lists _cl_result _cl_lhs _cl_rhs)
    cpp_assert_signature("${ARGV}" desc desc desc)

    list(LENGTH "${_cl_lhs}" _cl_lhs_n)
    list(LENGTH "${_cl_rhs}" _cl_rhs_n)

    # Ensure lists are same size, and catch empty list comparison
    if(NOT "${_cl_lhs_n}" EQUAL "${_cl_rhs_n}")
        set("${_cl_result}" FALSE PARENT_SCOPE)
        return()
    elseif("${_cl_lhs_n}" EQUAL 0) # Only 1 list being empty trips first clause
        set("${_cl_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Foreach uses closed ranges, we want half-open
    math(EXPR _cl_lhs_n "${_cl_lhs_n} - 1")

    # Now we compare the lists element-wise
    foreach(_cl_i RANGE "${_cl_lhs_n}")

        # Get the i-th element of each list
        list(GET "${_cl_lhs}" "${_cl_i}" _cl_lhs_i)
        list(GET "${_cl_rhs}" "${_cl_i}" _cl_rhs_i)

        # Compare the elements, returning false if they are not the same
        cpp_equal("${_cl_result}" "${_cl_lhs_i}" "${_cl_rhs_i}")
        if(NOT "${${_cl_result}}")
            cpp_return("${_cl_result}")
        endif()

    endforeach()

    # If we get this far the lists are the same
    set("${_cl_result}" TRUE PARENT_SCOPE)
endfunction()
