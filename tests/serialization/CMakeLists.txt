add_subdirectory(detail_)
# List of our unit tests
set(unit_tests serialization)
add_cmake_unit_tests("serialization" ${unit_tests})
