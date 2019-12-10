include_guard()

function(cpp_set_global _csg_key _csg_value)
    string(TOUPPER "${_csg_key}" _csg_key)
    set_property(GLOBAL PROPERTY "__CPP_${_csg_key}_GLOBAL__" "${_csg_value}")
endfunction()
