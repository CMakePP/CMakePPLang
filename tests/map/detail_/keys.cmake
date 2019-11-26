    include(cmake_test/cmake_test)

ct_add_test("_cpp_map_keys")
    include(cmakepp_core/map/map)


    ct_add_section("No keys")
        _cpp_map_ctor(a_map)
        _cpp_map_keys(result "${a_map}")
        ct_assert_equal(result "")
    ct_end_section()

    ct_add_section("1 key")
        _cpp_map_ctor(a_map)
        _cpp_map_add_key("${a_map}" a_key)
        _cpp_map_keys(result "${a_map}")
        ct_assert_equal(result "a_key")
    ct_end_section()

    ct_add_section("2 keys")
        _cpp_map_ctor(a_map)
        _cpp_map_add_key("${a_map}" a_key)
        _cpp_map_add_key("${a_map}" b_key)
        _cpp_map_keys(result "${a_map}")
        ct_assert_equal(result "a_key;b_key")
    ct_end_section()
ct_end_test()
