include_guard()
include(cmakepp_core/function/detail_/assert_not_ambiguous)
include(cmakepp_core/object/object)
include(cmakepp_core/overload/overload)

function(cpp_function_add_overload _fao_this)

    cpp_object(GET_ATTR "${_fao_this}" _fao_name "name")
    cpp_overload(CTOR _fao_overload "${_fao_name}" ${ARGN})
    _cpp_function_assert_not_ambiguous("${_fao_this}" "${_fao_overload}")
    cpp_object(GET_ATTR "${_fao_this}" _fao_overloads "overloads")
    list(APPEND _fao_overloads "${_fao_overload}")
    cpp_object(SET_ATTR "${_fao_this}" "overloads" "${_fao_overloads}")
endfunction()


