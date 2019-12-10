include_guard()

function(cpp_class _cc_type)
    _cpp_object_ctor("${_cc_type}")

    cpp_return("${_cc_type}")
endfunction()

function(cpp_member _cm_name _cm_type)
    _cpp_object_add_fxn("${${_cm_type}}" "${_cm_name}" ${ARGN})
    cpp_return("${_cm_name}")
endfunction()

function(cpp_attribute _ca_name _ca_type _ca_attr_type)
endfunction()

