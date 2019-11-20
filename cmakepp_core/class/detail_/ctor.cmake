include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/utilities/return)

#[[[ Constructs a new Class object
#]]
function(_cpp_class_ctor _ccc_result _ccc_type)
    cpp_assert_signature("${ARGV}" desc desc args)
    string(TOLOWER "${_ccc_type}" _ccc_lc_type)
    set(
        _ccc_impl_file
        "${CMAKE_CURRENT_BINARY_DIR}/cpp_classes/${_ccc_lc_type}.cmake"
    )
    cpp_map(CTOR "${_ccc_result}")
    cpp_array(CTOR _ccc_bases object ${ARGN})
    cpp_map(SET "${${_ccc_result}}" base_classes "${_ccc_bases}")
    cpp_map(CTOR _ccc_fxns)
    cpp_map(SET "${${_ccc_result}}" fxns "${_ccc_fxns}")
    cpp_map(SET "${${_ccc_result}}" impl_file "${_ccc_impl_file}")
    cpp_map(SET "${${_ccc_result}}" my_type "${_ccc_type}")
    cpp_map(SET "${${_ccc_result}}" src_file "${CMAKE_CURRENT_LIST_FILE}")
    cpp_return("${_ccc_result}")
endfunction()
