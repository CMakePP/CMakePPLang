include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/utilities/return)

#[[[ Encapsulates the process of comparing two CMake lists to one another.
#
# Two CMake lists are equal if they contain the same number of elements and if
# the :math:`i`-th element in ``_cl_lhs`` compares equal to the :math:`i`-th
# element of ``_cl_rhs`` under ``cpp_equal`` for all elements in the list. In
# particular this means that the lists must have the same order and that we
# compare the values of CMakePP objects, not their this-pointers.
#
# :param _cl_result: Name for variable which will hold the result.
# :type _cl_result: desc
# :param _cl_lhs: Identifier containing the first list to compare.
# :type _cl_lhs: list*
# :param _cl_rhs: Identifier containing the second list to comapre.
# :type _cl_rhs: list*
# :returns: ``_cl_result`` will be set to ``TRUE`` if the two lists are equal
#           and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode, this function will assert that the function
# is only provided three arguments (preventing the user from accidentally
# dereferencing one of the input lists in most cases) and that the arguments are
# all of type ``desc``.
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
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
