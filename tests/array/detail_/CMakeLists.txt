set(
    unit_tests append are_equal as_list back bounds_check copy ctor end find get
               length set
)
add_cmake_unit_tests("array" ${unit_tests})
