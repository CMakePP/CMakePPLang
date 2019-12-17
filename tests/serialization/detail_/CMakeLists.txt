# List of our unit tests
set(
    unit_tests serialize_list serialize_string serialize_value
)
add_cmake_unit_tests("serialization" ${unit_tests})

