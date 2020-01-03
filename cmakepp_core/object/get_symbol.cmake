include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/object/get_meta_attr)
include(cmakepp_core/types/is_callable)
include(cmakepp_core/utilities/return)

function(_cpp_object_get_symbol _ogs_this _ogs_result _ogs_sig)
    _cpp_object_get_meta_attr("${_ogs_this}" _ogs_fxns "fxns")
    cpp_map(KEYS "${_ogs_fxns}" _ogs_symbols)

    foreach(_ogs_symbol_i ${_ogs_symbols})
        cpp_map(GET "${_ogs_fxns}" _ogs_fxn_i "${_ogs_symbol_i}")
        cpp_is_callable(_ogs_good _ogs_fxn_i "${_ogs_sig}")
        if("${_ogs_good}")
            set("${_ogs_result}" "${_ogs_symbol_i}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    _cpp_object_get_meta_attr("${_ogs_this}" _ogs_sub_objects "sub_objs")
    cpp_map(KEYS "${_ogs_sub_objects}" _ogs_bases)

    foreach(_ogs_base_i ${_ogs_bases})
        cpp_map(GET "${_ogs_sub_objects}" _ogs_base_state "${_ogs_base_i}")
        _cpp_object_get_symbol(
            "${_ogs_base_state}" _ogs_has_symbol "${_ogs_sig}"
        )
        if(_ogs_has_symbol)
            set("${_ogs_result}" "${_ogs_has_symbol}" PARENT_SCOPE)
            return()
        endif()
    endforeach()

    set("${_ogs_result}" FALSE PARENT_SCOPE)
endfunction()
