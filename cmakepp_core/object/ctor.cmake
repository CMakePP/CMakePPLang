include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/object/get_meta_attr)
include(cmakepp_core/types/cmakepp_type)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/sanitize_string)

function(_cpp_object_ctor _oc_this _oc_type)
    cpp_map(CTOR _oc_fxns)
    cpp_map(CTOR _oc_attrs)
    cpp_map(CTOR _oc_sub_objs)

    foreach(_oc_sub_obj_i ${ARGN})
        _cpp_object_get_meta_attr("${_oc_sub_obj_i}" _oc_type_i "type")
        cpp_map(SET "${_oc_sub_objs}" "${_oc_type_i}" "${_oc_sub_obj_i}")
    endforeach()

    cpp_sanitize_string(_oc_type "${_oc_type}")
    cpp_map(CTOR _oc_state  _cpp_attrs "${_oc_attrs}"
                            _cpp_fxns "${_oc_fxns}"
                            _cpp_sub_objs "${_oc_sub_objs}"
                            _cpp_type "${_oc_type}"
    )

    cpp_unique_id("${_oc_this}")
    cpp_set_global("${${_oc_this}}__state" "${_oc_state}")
    _cpp_set_cmakepp_type("${${_oc_this}}" "${_oc_type}")
    cpp_return("${_oc_this}")
endfunction()
