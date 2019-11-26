set(
    unit_tests add_overload assert_class_is_registered class_guts ctor
               get_attrs get_class_registry get_fxns
               get_overloads register_member
    )
add_cmake_unit_tests(class ${unit_tests})
