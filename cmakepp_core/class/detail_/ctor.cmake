include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/type)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Constructs a new Class object
#]]
function(_cpp_class_ctor _ccc_result _ccc_type)
    cpp_assert_type(desc "${_ccc_result}" desc "${_ccc_type}")

    cpp_map(CTOR "${_ccc_result}")
    cpp_array(CTOR _ccc_bases)
    cpp_array(APPEND "${_ccc_bases}" object ${ARGN})
    cpp_map(SET "${${_ccc_result}}" my_type "${_ccc_type}")
    cpp_map(SET "${${_ccc_result}}" base_classes "${_ccc_bases}")
    cpp_return("${_ccc_result}")
endfunction()
