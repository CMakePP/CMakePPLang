include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/are_equal)
include(cmakepp_core/utilities/return)

function(_cpp_map_has_key _cmhk_result _cmhk_map _cmhk_key)
    cpp_assert_type(
        desc "${_cmhk_result}" map "${_cmhk_map}" desc "${_cmhk_key}"
    )
    get_property(
        "${_cmhk_result}"
        GLOBAL PROPERTY "${_cmhk_map}_key_${_cmhk_key}"
        DEFINED
    )
    cpp_are_equal("${_cmhk_result}" "${${_cmhk_result}}" "1")
    return("${_cmhk_result}")
endfunction()
