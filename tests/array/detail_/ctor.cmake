include(cmake_test/cmake_test)

ct_add_test("_cpp_array_ctor")
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/types/types)

    _cpp_array_ctor(an_array)

    ct_add_section("State is a map")
        get_property(arrays_map GLOBAL PROPERTY "${an_array}")
        cpp_get_type(result "${arrays_map}")
        ct_assert_equal(result map)
    ct_end_section()

    ct_add_section("Global variable with type")
        get_property(result GLOBAL PROPERTY "${an_array}_type")
        ct_assert_equal(result "array")
    ct_end_section()
ct_end_test()
