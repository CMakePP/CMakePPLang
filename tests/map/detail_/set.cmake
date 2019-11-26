include(cmake_test/cmake_test)

ct_add_test("_cpp_map_set")
    include(cmakepp_core/map/map)

    _cpp_map_ctor(a_map)

    ct_add_section("can set a key")
        _cpp_map_set("${a_map}" a_key a_value)
        _cpp_map_get(result "${a_map}" a_key)
        ct_assert_equal(result "a_value")

        ct_add_section("multiple sets overwrite value")
            _cpp_map_set("${a_map}" a_key another_value)
            _cpp_map_get(result "${a_map}" a_key)
            ct_assert_equal(result "another_value")
        ct_end_section()
    ct_end_section()
ct_end_test()

ct_add_test("_cpp_map_append")
    include(cmakepp_core/map/map)

    _cpp_map_ctor(a_map)

    ct_add_section("sets a key if it does not exist")
        _cpp_map_append("${a_map}" a_key a_value)
        _cpp_map_get(result "${a_map}" a_key)
        ct_assert_equal(result "a_value")

        ct_add_section("appends to the value if it exists")
            _cpp_map_append("${a_map}" a_key another_value)
            _cpp_map_get(result "${a_map}" a_key)
            ct_assert_equal(result "a_value;another_value")
        ct_end_section()
    ct_end_section()
ct_end_test()
