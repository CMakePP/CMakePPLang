include_guard()
include(cmakepp_core/asserts/type)

function(_cpp_map_set _cms_map _cms_key _cms_value)
    cpp_assert_type(map "${_cms_map}")

    _cpp_map_add_key("${_cms_map}" "${_cms_key}")
    set_property(GLOBAL PROPERTY "${_cms_map}_key_${_cms_key}" "${_cms_value}")
endfunction()
