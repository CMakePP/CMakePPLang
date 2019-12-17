include_guard()

function(cpp_set_global _csg_key _csg_value)
    string(TOUPPER "${_csg_key}" _csg_key)
    set_property(GLOBAL PROPERTY "__CPP_${_csg_key}_GLOBAL__" "${_csg_value}")
endfunction()

function(cpp_get_global _cgg_result _cgg_key)
    string(TOUPPER "${_cgg_key}" _cgg_key)
    get_property("${_cgg_result}" GLOBAL PROPERTY "__CPP_${_cgg_key}_GLOBAL__")
    set("${_cgg_result}" "${${_cgg_result}}" PARENT_SCOPE)
endfunction()
