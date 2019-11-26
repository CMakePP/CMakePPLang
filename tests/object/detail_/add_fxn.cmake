include_guard()

function(_cpp_object_add_fxn _coaf_type _coaf_name)
    _cpp_object_get_fxns(_coaf_fxns "${_coaf_type}")

    # Initialize a function for it if it does not exist
    cpp_map(HAS_KEY _coaf_has_fxn "${_coaf_fxns}" "${_coaf_name}")
    if(NOT "${_coaf_has_fxn}")
        cpp_map(CTOR _coaf_temp)
        cpp_map(SET "${_coaf_fxns}" "${_coaf_name}" "${_coaf_temp}")
    endif()

    _cpp_object_add_overload("${_coaf_type}" "${_coaf_name}" ${ARGN})
    cpp_return("${_coaf_name}")
endfunction()
