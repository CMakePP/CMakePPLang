include_guard()
include(cmakepp_core/types/assert_type)

function(_cpp_map_add_key _cmak_map _cmak_key)
    cpp_assert_type(map "${_cmak_map}")

    _cpp_map_has_key(_cmak_has_key "${_cmak_map}" "${_cmak_key}")
    if(NOT "${_cmak_has_key}")
        set_property(GLOBAL APPEND PROPERTY ${_cmak_map}_keys ${_cmak_key})
    endif()
endfunction()
