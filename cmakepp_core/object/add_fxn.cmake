include_guard()

function(_cpp_object_add_fxn _oaf_this _oaf_name)
    _cpp_object_get_meta_attr("${_oaf_this}" _oaf_type "type")
    cpp_sanitize_string(_oaf_nice_name "${_oaf_name}")
    set(_oaf_mn "_cpp_${_oaf_type}_${_oaf_nice_name}_")
    set(_oaf_value "${_oaf_nice_name}")
    foreach(_oaf_arg_i ${ARGN})
        cpp_sanitize_string(_oaf_nice_arg "${_oaf_arg_i}")
        string(APPEND _oaf_mn "${_oaf_nice_arg}_")
        list(APPEND _oaf_value "${_oaf_nice_arg}")
    endforeach()

    _cpp_object_get_meta_attr("${_oaf_this}" _oaf_fxns "fxns")
    cpp_map(SET "${_oaf_fxns}" "${_oaf_mn}" "${_oaf_value}")

    set("${_oaf_name}" "${_oaf_mn}" PARENT_SCOPE)
endfunction()
