include(cmake_test/cmake_test)

ct_add_test("_cpp_map_ctor")
    include(cmakepp_core/map/map)

    ct_add_section("Default ctor")
        _cpp_map_ctor(my_map)
        ct_add_section("Defines a global variable for the keys")
            get_property(result GLOBAL PROPERTY ${my_map}_keys DEFINED)
            ct_assert_equal(result 1)
        ct_end_section()

        ct_add_section("Sets a global variable for the type")
            get_property(result GLOBAL PROPERTY "${my_map}_type")
            ct_assert_equal(result map)
        ct_end_section()
    ct_end_section()

    ct_add_section("Initializer ctor")
        _cpp_map_ctor(my_map a_key a_value
                             another_key another_value
                             wow_3_keys 42
        )
        _cpp_map_get(value0 "${my_map}" a_key)
        ct_assert_equal(value0 a_value)

        _cpp_map_get(value1 "${my_map}" another_key)
        ct_assert_equal(value1 another_value)

        _cpp_map_get(value2 "${my_map}" wow_3_keys)
        ct_assert_equal(value2 42)
    ct_end_section()
ct_end_test()
