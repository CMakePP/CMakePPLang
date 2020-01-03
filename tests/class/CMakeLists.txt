add_subdirectory(detail_)
set(unit_tests add_attribute add_member class ctor)
add_cmake_unit_tests(class ${unit_tests})
