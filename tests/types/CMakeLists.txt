add_subdirectory(detail_)
set(unit_tests get_type get_types implicitly_convertible)
add_cmake_unit_tests("types" ${unit_tests})
