include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/utilities/return)

#[[[ Encapsulates the process of comparing two CMake lists to one another.
#
# :param _cl_result:
#]]
function(cpp_compare_lists _cl_result _cl_lhs _cl_rhs)

    list(LENGTH "${_cl_lhs}" _cl_lhs_n)
    list(LENGTH "${_cl_rhs}" _cl_rhs_n)

    # Ensure lists are same size, and catch empty list comparison
    if(NOT "${_cl_lhs_n}" EQUAL "${_cl_rhs_n}")
        set("${_cl_result}" FALSE PARENT_SCOPE)
        return()
    elseif("${_cl_lhs_n}" EQUAL 0) # Only one being empty trips first clause
        set("${_cl_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Foreach uses closed ranges, we want half-open
    math(EXPR _cl_lhs_n "${_cl_lhs_n} - 1")
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
