include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_map")
    include(cmakepp_core/serialization/serialization)

    ct_add_section("Empty map")
        cpp_map(CTOR a_map)
        _cpp_serialize_map(result "${a_map}")
        ct_assert_equal(result "{ }")
    ct_end_section()

    ct_add_section("Single key, value pair")
        cpp_map(CTOR a_map foo bar)
        _cpp_serialize_map(result "${a_map}")
        ct_assert_equal(result [[{ "foo" : "bar" }]])
    ct_end_section()

    ct_add_section("Two key, value pair")
        cpp_map(CTOR a_map foo bar hello world)
        _cpp_serialize_map(result "${a_map}")
        ct_assert_equal(result [[{ "foo" : "bar", "hello" : "world" }]])
    ct_end_section()
ct_end_test()
