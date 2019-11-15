set(
    unit_tests are_equal assert enable_if_debug negate protect_list return
               ternary_op tuple_iterator
)
add_cmake_unit_tests("utilities" ${unit_tests})
