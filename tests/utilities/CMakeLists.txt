set(
    unit_tests assert call_fxn enable_if_debug file_exists negate print_fxn_sig
               protect_list read_template return ternary_op tuple_iterator
               unique_id
)
add_cmake_unit_tests("utilities" ${unit_tests})
