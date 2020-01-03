include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/object/get_meta_attr)
include(cmakepp_core/utilities/return)

function(_cpp_object_get_attr_guts _ogag_this _ogag_value _ogag_done _ogag_attr)
    _cpp_object_get_meta_attr("${_ogag_this}" _ogag_attrs "attrs")
    cpp_map(HAS_KEY "${_ogag_attrs}" _ogag_has_key "${_ogag_attr}")
    if(_ogag_has_key)
        cpp_map(GET "${_ogag_attrs}" "${_ogag_value}" "${_ogag_attr}")
        set("${_ogag_done}" TRUE PARENT_SCOPE)
        cpp_return("${_ogag_value}")
    endif()

    _cpp_object_get_meta_attr("${_ogag_this}" _ogag_sub_objs "sub_objs")
    cpp_map(KEYS "${_ogag_sub_objs}" _ogag_bases)
    foreach(_ogag_type_i ${_ogag_bases})
        cpp_map(GET "${_ogag_sub_objs}" _ogag_base_i "${_ogag_type_i}")
        _cpp_object_get_attr_guts(
           "${_ogag_base_i}" "${_ogag_value}" _ogag_found "${_ogag_attr}"
        )
        if(_ogag_found)
            set("${_ogag_done}" TRUE PARENT_SCOPE)
            cpp_return("${_ogag_value}")
        endif()
    endforeach()

    set("${_ogag_done}" FALSE PARENT_SCOPE)
endfunction()

function(_cpp_object_get_attr _oga_this _oga_value _oga_attr)
    _cpp_object_get_attr_guts(
        "${_oga_this}" "${_oga_value}" _oga_found "${_oga_attr}"
    )

    if(_oga_found)
        cpp_return("${_oga_value}")
    endif()

    message(FATAL_ERROR "Instance has no attribute ${_oga_attr}")
endfunction()

function(_cpp_object_set_attr _osa_this _osa_attr _osa_value)
    _cpp_object_get_meta_attr("${_osa_this}" _osa_attrs "attrs")
    cpp_map(SET "${_osa_attrs}" "${_osa_attr}" "${_osa_value}")
endfunction()
