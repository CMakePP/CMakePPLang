include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_map")
    include(cmakepp_core/serialization/detail_/serialize_map)

    ct_add_section("empty map")
        cpp_map(CTOR my_map)
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(result [[{ }]])
    ct_end_section()

    ct_add_section("map with one pair")
        cpp_map(CTOR my_map a_key a_value)
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(result [[{ "a_key" : "a_value" }]])
    ct_end_section()

    ct_add_section("map with two pairs")
        cpp_map(CTOR my_map a_key a_value key2 42)
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(
            result
            [[{ "a_key" : "a_value" , "key2" : "42" }]])
    ct_end_section()

    ct_add_section("map with a map")
        cpp_map(CTOR sub_map)
        cpp_map(CTOR my_map a_key "${sub_map}")
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(result [[{ "a_key" : { } }]])
    ct_end_section()

    ct_add_section("map with a list")
        cpp_map(CTOR my_map a_key [[hello\;world]])
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(result [[{ "a_key" : [ "hello" , "world" ] }]])
    ct_end_section()

    ct_add_section("map with an array")
        cpp_array(CTOR an_array)
        cpp_map(CTOR my_map a_key "${an_array}")
        _cpp_serialize_map(result "${my_map}")
        ct_assert_equal(result [[{ "a_key" : { "array" : [ ] } }]])
    ct_end_section()
ct_end_test()
