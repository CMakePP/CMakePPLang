set(
    unit_tests add_overload assert_not_ambiguous call_overload get_mangled_name
               get_overloads is_match mangle_fxn
)
add_cmake_unit_tests("function" ${unit_tests})
