set(
    unit_tests add_base add_function ctor equal get_state mangled_name merge
               set_attr set_type
)
add_cmake_unit_tests(object ${unit_tests})
