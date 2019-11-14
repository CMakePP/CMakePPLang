includ_guard()

function(cpp_map_has_key _cmhk_result _cmhk_map _cmhk_key)
    cpp_assert_signature(
            str "${_cmhk_result}" map "${_cmhk_map}" str "${_cmhk_key}"
    )
    cpp_ternary_op(
            "${_cim_result}" "DEFINED;${${_cmhk_map}}_${_cmhk_key}" TRUE FALSE
    )
    return("${_cim_result}")
endfunction()
