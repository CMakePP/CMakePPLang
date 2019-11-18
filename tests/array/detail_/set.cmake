include(cmake_test/cmake_test)

ct_add_test("_cpp_array_set")
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/array/detail_/append)
    include(cmakepp_core/array/detail_/set)

    _cpp_array_ctor(my_array)
    _cpp_array_append("${my_array}" a_value another_value)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: array")
            _cpp_array_set(TRUE 0 a_value)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Arg2: int")
            _cpp_array_set("${my_array}" TRUE a_value)
            ct_assert_fails_as("Assertion: TRUE is int")
        ct_end_section()
    ct_end_section()

    ct_add_section("change element 0")
        _cpp_array_get(result "${my_array}" 0)
        ct_assert_equal(result a_value)

        _cpp_array_set("${my_array}" 0 42)
        _cpp_array_get(result "${my_array}" 0)
        ct_assert_equal(result 42)
    ct_end_section()

    ct_add_section("Fails if index is out of bounds")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_array_set("${my_array}" 42 a_value)
        ct_assert_fails_as("Assertion: 42 < 2")
    ct_end_section()
ct_end_test()
