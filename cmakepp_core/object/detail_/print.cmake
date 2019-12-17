include_guard()
include(cmakepp_core/serialization/serialization)
include(cmakepp_core/utilities/get_global)
include(cmakepp_core/utilities/return)

function(_cpp_object_print _cop_object _cop_output)

    cpp_get_global(_cop_state "${_cop_object}")
    cpp_serialize("${_cop_output}" "${_cop_state}")
    cpp_return("${_cop_output}")
endfunction()
