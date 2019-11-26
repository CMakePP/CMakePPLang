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



    # Start the map
    cpp_map(CTOR "${_ccc_result}")

    # Add a map for the class's attributes
    cpp_map(CTOR _ccc_attr)
    cpp_map(SET "${${_ccc_result}}" attributes "${_ccc_attr}")

    # Add an array of base classes
    cpp_array(CTOR _ccc_bases ${ARGN})
    cpp_map(SET "${${_ccc_result}}" base_classes "${_ccc_bases}")

    # Add a map for member functions
    cpp_map(CTOR _ccc_fxns)
    cpp_map(SET "${${_ccc_result}}" fxns "${_ccc_fxns}")

    # Record the file with implementations so we can include it dynamically
    cpp_map(SET "${${_ccc_result}}" src_file "${CMAKE_CURRENT_LIST_FILE}")

    cpp_return("${_ccc_result}")
endfunction()
