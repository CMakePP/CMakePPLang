include_guard()
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/detail_/key_mangle)
include(cmakepp_core/utilities/are_equal)
include(cmakepp_core/utilities/return)

function(_cpp_map_has_key _cmhk_result _cmhk_map _cmhk_key)
    cpp_assert_type(
        desc "${_cmhk_result}" map "${_cmhk_map}" desc "${_cmhk_key}"
    )
    _cpp_map_key_mangle(_cmhk_key_identifier "${_cmhk_map}" "${_cmhk_key}")
    get_property(
        "${_cmhk_result}" GLOBAL PROPERTY "${_cmhk_key_identifier}" DEFINED
    )
    message("${_cmhk_result} == ${${_cmhk_result}}")
    cpp_are_equal("${_cmhk_result}" "${${_cmhk_result}}" "1")
    message("${_cmhk_result} == ${${_cmhk_result}}")
    return("${_cmhk_result}")
endfunction()
