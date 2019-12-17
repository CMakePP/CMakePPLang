include_guard()
include(cmakepp_core/function/add_overload)
include(cmakepp_core/object/object)

function(cpp_function_ctor _fc_this _fc_name)

    cpp_object(CTOR "${_fc_this}")
    cpp_object(_SET_TYPE "${${_fc_this}}" "function")

    cpp_object(SET_ATTR "${${_fc_this}}" "name" "${_fc_name}")
    cpp_object(SET_ATTR "${${_fc_this}}" "overloads" "")

    if("${ARGC}" GREATER 1)
        cpp_function_add_overload("${${_fc_this}}" ${ARGN})
    endif()
    cpp_return("${_fc_this}")
endfunction()
