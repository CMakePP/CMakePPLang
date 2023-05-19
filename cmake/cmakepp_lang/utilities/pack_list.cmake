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
# Defines functions for packing and unpacking a CMake list into a string that
# can be passed through function calls.
#]]

include_guard()

include(cmakepp_lang/serialization/serialization)

#[[[
# Transforms a CMake list into a string that can be passed down through
# function calls and then transformed back to the original CMake list that
# retains the original nesting structure of the list.
#
# This function will take a CMake list and replace list separator characters at
# various levels of nesting with "_CPP_{N}_CPP_" where N is the level of
# nesting. N will be 0 for the top level list, 1 for the next level down, and so
# on.
#
# For example, take a list declared with the command:
# set(my_list a;b\\\;c\\\\\;cc\\\;bb;aa)
#
# my_list serializes to the (much more easily read) form:
# [ "a", [ "b", [ "c", "cc" ], "bb" ], "aa" ]
#
# my_list will be transformed to the packed list string:
# a_CPP_0_CPP_b_CPP_1_CPP_c_CPP_2_CPP_cc_CPP_1_CPP_bb_CPP_0_CPP_aa
#
# :param result: The name for the variable which will hold the result.
# :type result: desc
# :param list: The list we want to pack into a string.
# :type result: list
# :returns: ``result`` will be set to the resulting packed list string.
# :rtype: desc
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_pack_list`` will assert that it has
# been called with two arguments and that those arguments are of the correct
# types.
#]]
function(cpp_pack_list _pl_result _pl_list)
    cpp_assert_signature("${ARGV}" desc list)

    # Get the depth argument, if no depth was set, set it to 0
    cmake_parse_arguments(_pl "" DEPTH "" ${ARGN})
    if(NOT _pl_DEPTH)
        set(_pl_DEPTH 0)
    endif()

    # Start the result string
    set(_pl_packed_list "")

    # Start a counter and capture length of list
    set(_pl_counter 0)
    list(LENGTH _pl_list _pl_n_elems)

    # Calc next depth
    math(EXPR _pl_next_depth "${_pl_DEPTH} + 1")

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 _pl_delim)

    # Loop over elements in list
    foreach(_pl_elem ${_pl_list})
        # Get the type of current element
        cpp_type_of(_pl_elem_type "${_pl_elem}")
        if(_pl_elem_type STREQUAL "list")
            # If element is a list, recursively pack it and add it to result
            cpp_pack_list(_pl_elem_result "${_pl_elem}" DEPTH ${_pl_next_depth})
            string(APPEND _pl_packed_list "${_pl_elem_result}")
        else()
            # If the element is not a list, just add it to result
            string(APPEND _pl_packed_list "${_pl_elem}")
        endif()

        # Update counter
        math(EXPR _pl_counter "${_pl_counter} + 1")
        if("${_pl_counter}" LESS "${_pl_n_elems}")
            # Add a seperation character if this is not the last item
            string(APPEND _pl_packed_list "_${_pl_delim}_${_pl_DEPTH}_${_pl_delim}_")
        endif()
    endforeach()

    # Return the result
    set("${_pl_result}" "${_pl_packed_list}" PARENT_SCOPE)
endfunction()

#[[[
# Transforms a string generated from a list being passed to cpp_pack_list
#    back into the original CMake list, retaining the nesting structure.
#
# This function will take a packed list string and replace the "_CPP_{N}_CPP_"
# list separator placeholders with actual CMake list seperators with the
# the appropriate number of escape characters with respect to the nesting level
# of the list separator placeholders (N).
#
# For example take a packed list string:
# a_CPP_0_CPP_b_CPP_1_CPP_c_CPP_2_CPP_cc_CPP_1_CPP_bb_CPP_0_CPP_aa
#
# This string will be transformed into a list that serializes to:
# [ "a", [ "b", [ "c", "cc" ], "bb" ], "aa" ]
#
# :param result: The name for the variable which will hold the result.
# :type result: desc
# :param packed_list: The string we want to transform to a CMake list.
# :type packed_list: desc
# :returns: ``result`` will be set to the resulting CMake list.
# :rtype: desc
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_unpack_list`` will assert that it has
# been called with two arguments and that those arguments are of the correct
# types.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
#]]
function(cpp_unpack_list _ul_result _ul_packed_list)
    cpp_assert_signature("${ARGV}" desc desc)

    # Get the depth argument, if no depth was set, set it to 0
    cmake_parse_arguments(_ul "" DEPTH "" ${ARGN})
    if(NOT _ul_DEPTH)
        set(_ul_DEPTH 0)
    endif()

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 _ul_delim)

    # Create the current string we want to replace
    set(_ul_search "_${_ul_delim}_${_ul_DEPTH}_${_ul_delim}_")

    # Calculate string to replace search string with
    if(_ul_DEPTH EQUAL 0)
        # Depth 0 just gets ";"
        set(_ul_replace ";")
    else()
        # Lower depths get "\\" for each level of depth and an additional "\;"
        set(_ul_replace ";")
        foreach(n RANGE 1 ${_ul_DEPTH})
            string(PREPEND _ul_replace "\\")
        endforeach()
    endif()

    # Look for seperation characters
    string(FIND "${_ul_packed_list}" "${_ul_search}" _ul_find_result)
    if(_ul_find_result EQUAL -1)
        # No seperation characters to replace here, return list
        set("${_ul_result}" "${_ul_packed_list}" PARENT_SCOPE)
        return()
    else()
        # Replace seperation characters
        string(
            REPLACE "${_ul_search}" "${_ul_replace}"
            _ul_packed_list "${_ul_packed_list}"
        )

        # Calculate next depth
        math(EXPR _ul_next_depth "${_ul_DEPTH} + 1")

        # Recursively unpack all levels and return result
        cpp_unpack_list(_ul_packed_list "${_ul_packed_list}" DEPTH ${_ul_next_depth})
        set("${_ul_result}" "${_ul_packed_list}" PARENT_SCOPE)
    endif()
endfunction()
