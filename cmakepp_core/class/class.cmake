include_guard()
include(cmakepp_core/class/detail_/bases)
include(cmakepp_core/object/object)
include(cmakepp_core/types/cmakepp_type)

set(__CPP_CLASS_TEMPLATE__ "${CMAKE_CURRENT_LIST_DIR}/detail_/class.cmake.in")

function(_cpp_class_guts _cg_type _cg_wrapper)
    if("${ARGC}" EQUAL 2)
        set(_cg_bases "obj")
        set(_cg_base_instances "${__CPP_OBJECT_SINGLETON__}")
    else()
        set(_cg_bases "")
        set(_cg_base_instances "")
        foreach(_cg_base_i ${ARGN})
            cpp_get_global(_cg_default_base_i "${_cg_base_i}__state")
            list(APPEND _cg_base_instances "${_cg_default_base_i}")

            cpp_get_global(_cg_base_i_bases "${_cg_base_i}__bases")
            cpp_sanitize_string(_cg_nice_base "${_cg_base_i}")
            list(APPEND _cg_bases "${_cg_base_i_bases}" "${_cg_nice_base}")
        endforeach()
        list(REMOVE_DUPLICATES _cg_bases)
    endif()

    # Set the type before calling any ``Class`` members so we can type check
    _cpp_set_cmakepp_type("${_cg_type}" "class")

    _cpp_object_ctor(_cg_default "${_cg_type}" ${_cg_base_instances})
    _cpp_class_set_bases("${_cg_type}" _cg_bases)
    cpp_set_global("${_cg_type}__state" "${_cg_default}")

    set(
        "${_cg_wrapper}"
        "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/classes/${_cg_type}.cmake"
    )
    configure_file("${__CPP_CLASS_TEMPLATE__}" "${${_cg_wrapper}}" @ONLY)
    cpp_return("${_cg_wrapper}")
endfunction()

macro(cpp_class _c_type)
    _cpp_class_guts("${_c_type}" "_${_c_type}_wrapper" ${ARGN})
    include("${_${_c_type}_wrapper}")
endmacro()

function(cpp_member _m_name _m_type)
    cpp_get_global(_m_state "${_m_type}__state")
    _cpp_object_add_fxn("${_m_state}" "${_m_name}" "${_m_type}" ${ARGN})
    cpp_return("${_m_name}")
endfunction()

function(cpp_attr _a_type _a_attr)
    cpp_get_global(_a_state "${_a_type}__state")
    _cpp_object_set_attr("${_a_state}" "${_a_attr}" "${ARGN}")
endfunction()

macro(cpp_end_class)
endmacro()
