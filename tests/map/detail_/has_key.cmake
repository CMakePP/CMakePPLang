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

    ct_add_section("CMakePP Object as key")
        include(cmakepp_core/array/array)
        cpp_array(CTOR an_array 1 2 3)

        ct_add_section("Does not have key")
            _cpp_map_has_key(result "${my_map}" "${an_array}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Has key")
            _cpp_map_add_key("${my_map}" "${an_array}")
            ct_add_section("Same key instance")
                _cpp_map_has_key(result "${my_map}" "${an_array}")
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("Different key instance")
                cpp_array(CTOR another_array 1 2 3)
                _cpp_map_has_key(result "${my_map}" "${another_array}")
            ct_end_section()
        ct_end_section()
    ct_end_section()
ct_end_test()
