set(
    unit_tests add_fxn attrs call copy ctor equal get_meta_attr get_symbol
               serialize singleton
)
add_cmake_unit_tests(object ${unit_tests})
