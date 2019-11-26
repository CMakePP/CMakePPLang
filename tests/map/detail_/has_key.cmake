include(cmake_test/cmake_test)

ct_add_test("_cpp_map_has_key")
    include(cmakepp_core/map/map)

    _cpp_map_ctor(my_map)

    ct_add_section("Is a key")
        _cpp_map_add_key("${my_map}" a_key)
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Is not a key")
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
