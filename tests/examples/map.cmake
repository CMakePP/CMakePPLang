include(cmake_test/cmake_test)

ct_add_test("How to Use the CMakePP Map Class")

include(cmakepp_core/map/map)

cpp_map(CTOR my_map)
cpp_map(SET ${my_map} a_key a_value)
cpp_map(GET result ${my_map} a_key)

message("a_key = ${result}")
ct_assert_equal(result a_value)

cpp_map(HAS_KEY result ${my_map} a_key)
message("Has the key 'a_key' : ${result}")
ct_assert_equal(result TRUE)

cpp_map(KEYS result ${my_map})
message("List of keys: [${result}]")
ct_assert_equal(result "a_key")

ct_end_test()
