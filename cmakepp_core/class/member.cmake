include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/class/detail_/get_class_registry)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/print_fxn_sig)

include(cmakepp_core/class/detail_/mangle_fxn)
include(cmakepp_core/class/detail_/register_member)


function(_cpp_class_add_overload _ccho_type _ccho_fxn_name)
    # Get list of overloads for this function
    _cpp_class_get_fxns(_ccho_fxns "${_ccho_type}")
    cpp_map(GET _ccho_overloads "${_ccho_fxns}" "${_ccho_fxn_name}")

    # Mangle the name
    _cpp_mangle_fxn(_ccho_mangle "${_ccho_fxn_name}" "${_ccho_type}" ${ARGN})

    # Check the overload doesn't exist
    cpp_array(FIND _ccho_has_overload "${_ccho_overloads}" "${_ccho_mangle}")

    if("${_ccho_has_overload}" STREQUAL "NOTFOUND")
        cpp_array(APPEND "${_ccho_overloads}" "${_ccho_mangle}")
    else()
        cpp_print_fxn_sig(_ccho_sig "${_ccho_fxn_name}" ${ARGN})
        cpp_assert(FALSE "${_ccho_sig} does not exist")
    endif()
endfunction()

function(cpp_member _cm_fxn_name _cm_type)
    cpp_assert_signature("${ARGV}" desc desc args)

    _cpp_class_register_member("${_cm_type}" "${_cm_fxn_name}")
    _cpp_class_add_overload("${_cm_type}" "${_cm_fxn_name}" ${ARGN})

    _cpp_mangle_fxn(_cm_mangle "${_cm_fxn_name}" "${_cm_type}" ${ARGN})
    set("${_cm_fxn_name}" "${_cm_mangle}" PARENT_SCOPE)
endfunction()
