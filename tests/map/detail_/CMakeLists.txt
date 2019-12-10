set(
    unit_tests add_key are_equal assert_has_key copy ctor get has_key
               keys merge set
)
add_cmake_unit_tests(map ${unit_tests})
