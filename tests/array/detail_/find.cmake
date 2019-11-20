include(cmake_test/cmake_test)

ct_add_test("_cpp_array_find")
    include(cmakepp_core/array/array)

    ct_add_section("Empty Array")
        cpp_array(CTOR an_array)
        _cpp_array_find(result "${an_array}" hello)
        ct_assert_equal(result NOTFOUND)
    ct_end_section()

    ct_add_section("Non-empty Array")
        cpp_array(CTOR an_array hello world)

        ct_add_section("Contains the value")
            _cpp_array_find(result "${an_array}" hello)
            ct_assert_equal(result 0)
        ct_end_section()

        ct_add_section("Does not contain the value")
            _cpp_array_find(result "${an_array}" 42)
            ct_assert_equal(result NOTFOUND)
        ct_end_section()
    ct_end_section()
ct_end_test()
