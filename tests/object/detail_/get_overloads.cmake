function(_cpp_object_get_overloads _cogo_overloads _cogo_type _cogo_fxn)
    cpp_assert_signature("${ARGV}" desc desc desc)
    _cpp_object_assert_has_member_fxn("${_cogo_type}" "${_cogo_fxn}")

    _cpp_object_get_fxns(_cogo_fxns "${_cogo_type}")
    cpp_map(GET "${_cogo_overloads}" "${_cogo_fxns}" "${_cogo_fxn}")
    cpp_return("${_cogo_overloads}")
endfunction()
