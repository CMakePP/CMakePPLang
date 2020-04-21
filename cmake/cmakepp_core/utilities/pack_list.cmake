include_guard()
include(cmakepp_core/serialization/serialization)

#[[[ Transforms a CMake list into a string that can be passed down through
#    function calls and then transformed back to the original CMake list that
#    retains the original nesting structure of the list.
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
# :param _p_result: The name for the variable which will hold the result.
# :type _p_result: desc
# :param _p_list: The list we want to pack into a string.
# :type _p_result: list
# :returns: ``_p_result`` will be set to the resulting packed list string.
# :rtype: desc
#]]
function(cpp_pack_list _p_result _p_list)
    # Get the depth argument, if no depth was set, set it to 0
    cmake_parse_arguments(_p "" DEPTH "" ${ARGN})
    if(NOT _p_DEPTH)
        set(_p_DEPTH 0)
    endif()

    # Start the result string
    set(_p_packed_list "")

    # Start a counter and capture length of list
    set(_p_counter 0)
    list(LENGTH _p_list _p_n_elems)

    # Calc next depth
    math(EXPR _p_next_depth "${_p_DEPTH} + 1")

    # Loop over elements in list
    foreach(_p_elem ${_p_list})
        # Get the type of current element
        cpp_type_of(_p_elem_type "${_p_elem}")
        if(_p_elem_type STREQUAL "list")
            # If element is a list, recursively pack it and add it to result
            cpp_pack_list(_p_elem_result "${_p_elem}" DEPTH ${_p_next_depth})
            string(APPEND _p_packed_list "${_p_elem_result}")
        else()
            # If the element is not a list, just add it to result
            string(APPEND _p_packed_list "${_p_elem}")
        endif()

        # Update counter
        math(EXPR _p_counter "${_p_counter} + 1")
        if("${_p_counter}" LESS "${_p_n_elems}")
            # Add a seperation character if this is not the last item
            string(APPEND _p_packed_list "_CPP_${_p_DEPTH}_CPP_")
        endif()
    endforeach()

    # Return the result
    set("${_p_result}" "${_p_packed_list}" PARENT_SCOPE)
endfunction()

#[[[ Transforms a string generated from a list being passed to cpp_pack_list
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
# :param _up_result: The name for the variable which will hold the result.
# :type _up_result: desc
# :param _up_packed_list: The string we want to transform to a CMake list.
# :type _up_packed_list: desc
# :returns: ``_up_result`` will be set to the resulting CMake list.
# :rtype: desc
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode ``cpp_unpack_list`` will assert that it has
# been called with two arguments and that those arguments are of the correct
# types.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
#]]
function(cpp_unpack_list _up_result _up_packed_list)
    cpp_assert_signature("${ARGV}" desc desc)

    # Get the depth argument, if no depth was set, set it to 0
    cmake_parse_arguments(_up "" DEPTH "" ${ARGN})
    if(NOT _up_DEPTH)
        set(_up_DEPTH 0)
    endif()

    # Create the current string we want to replace
    set(_up_search "_CPP_${_up_DEPTH}_CPP_")

    # Calculate string to replace search string with
    if(_up_DEPTH EQUAL 0)
        # Depth 0 just gets ";"
        set(_up_replace ";")
    else()
        # Lower depths get "\\" for each level of depth and an additional "\;"
        set(_up_replace ";")
        foreach(n RANGE 1 ${_up_DEPTH})
            string(PREPEND _up_replace "\\")
        endforeach()
    endif()

    # Look for seperation characters
    string(FIND "${_up_packed_list}" "${_up_search}" _up_find_result)
    if(_up_find_result EQUAL -1)
        # No seperation characters to replace here, return list
        set("${_up_result}" "${_up_packed_list}" PARENT_SCOPE)
        return()
    else()
        # Replace seperation characters
        string(
            REPLACE "${_up_search}" "${_up_replace}"
            _up_packed_list "${_up_packed_list}"
        )

        # Calculate next depth
        math(EXPR _up_next_depth "${_up_DEPTH} + 1")

        # Recursively unpack all levels and return result
        cpp_unpack_list(_up_packed_list "${_up_packed_list}" DEPTH ${_up_next_depth})
        set("${_up_result}" "${_up_packed_list}" PARENT_SCOPE)
    endif()
endfunction()
