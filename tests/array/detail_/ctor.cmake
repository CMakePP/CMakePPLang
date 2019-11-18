include(cmake_test/cmake_test)

ct_add_test("_cpp_array_mangle")
    include(cmakepp_core/array/detail_/ctor)

    ct_add_section("Value")
        _cpp_array_mangle(result)
        string(FIND "${result}" "__cpp_array_" result)
        ct_assert_equal(result 0)
    ct_end_section()
ct_end_test()

ct_add_test("_cpp_array_ctor")
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/types/types)

    ct_add_section("state")
        _cpp_array_ctor(result)
        get_property(result GLOBAL PROPERTY "${result}")
        cpp_get_type(result "${result}")
        ct_assert_equal(result map)
    ct_end_section()
ct_end_test()
