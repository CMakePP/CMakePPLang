include_guard()
include(cmakepp_core/serialization/serialization)
include(cmakepp_core/utilities/return)

function(_cpp_array_print _cap_array _cap_output)

    cpp_serialize("${_cap_output}" "${_cap_array}")
    cpp_return("${_cap_output}")
endfunction()

