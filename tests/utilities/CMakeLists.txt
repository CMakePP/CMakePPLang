set(
    unit_tests assert enable_if_debug extract_args negate print_fxn_sig
               protect_list read_template return ternary_op tuple_iterator
               unique_id
)
add_cmake_unit_tests("utilities" ${unit_tests})
