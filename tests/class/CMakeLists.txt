add_subdirectory(detail_)
set(unit_tests attr class end_class member)
add_cmake_unit_tests(class ${unit_tests})
