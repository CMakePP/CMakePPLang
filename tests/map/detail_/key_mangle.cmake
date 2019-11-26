include(cmake_test/cmake_test)

ct_add_test("_cpp_map_key_mangle")
    include(cmakepp_core/map/map)

    ct_add_section("mangles correctly")
        _cpp_map_ctor(a_map)
        _cpp_map_key_mangle(result "${a_map}" the_key)
        ct_assert_equal(result "${a_map}_key_the_key")
    ct_end_section()
ct_end_test()
