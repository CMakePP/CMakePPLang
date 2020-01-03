include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)

function(_cpp_object_equal _oe_this _oe_result _oe_other)
    cpp_get_global(_oe_this_type "${_oe_this}__type")
    cpp_get_global(_oe_other_type "${_oe_other}__type")

    if(NOT "${_oe_this_type}" STREQUAL "${_oe_other_type}")
        set("${_oe_result}" FALSE PARENT_SCOPE)
        return()
    endif()

    cpp_get_global(_oe_this_state "${_oe_this}__state")
    cpp_get_global(_oe_other_state "${_oe_other}__state")
    cpp_map(EQUAL "${_oe_this_state}" "${_oe_result}" "${_oe_other_state}")
    cpp_return("${_oe_result}")
endfunction()
