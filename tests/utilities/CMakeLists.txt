set(
    unit_tests assert call_fxn compare_lists enable_if_debug file_exists global
               print_fxn_sig return unique_id
)
add_cmake_unit_tests("utilities" ${unit_tests})
