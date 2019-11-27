set(
    unit_tests generate_assert generate_call generate_header generate_signature
               generate_wrapper mangle_fxn
)
add_cmake_unit_tests("function" ${unit_tests})
