include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/utilities/return)

#[[[ Syntactic sugar for logical operations
#
# It is our opinion that statements like:
#
# .. code-block:: cmake
#
#    cpp_logic(result 3 < 4)
#    cpp_logic(result "${x}" == "${y}")
#    cpp_logic(result "${x}" in "${y}")
#
# are easier to read than the corresponding statements:
#
# .. code-block:: cmake
#
#    cpp_less(result 3 4)
#    cpp_equal(result "${x}" "${y}")
#    cpp_contains(result "${x}" "${y}"
#]]
function(cpp_logic _cl_result _cl_lhs _cl_op _cl_rhs)
    if("${_cl_op}" STREQUAL "==")
        cpp_equal("${_cl_result}" "${_cl_lhs}" "${_cl_rhs}")
    elseif("${_cl_op}" STREQUAL "!=")
        cpp_equal("${_cl_result}" "${_cl_lhs}" "${_cl_rhs}")
        cpp_negate("${_cl_result}")
    elseif("${_cl_op}" STREQUAL "in")
        cpp_contains("${_cl_result}" "${_cl_lhs}" "${_cl_rhs}")
    endif()
    cpp_return("${_cl_result}")
endfunction()
