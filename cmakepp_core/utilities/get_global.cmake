include_guard()
include(cmakepp_core/utilities/return)

function(cpp_get_global _cgg_result _cgg_key)
    string(TOUPPER "${_cgg_key}" _cgg_key)
    get_property("${_cgg_result}" GLOBAL PROPERTY "__CPP_${_cgg_key}_GLOBAL__")
    cpp_return("${_cgg_result}")
endfunction()
