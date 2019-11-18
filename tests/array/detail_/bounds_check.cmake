include(cmake_test/cmake_test)

ct_add_test("_cpp_array_bounds_check")
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/array/detail_/append)
    include(cmakepp_core/array/detail_/bounds_check)

    set(CMAKEPP_CORE_DEBUG_MODE ON)
    _cpp_array_ctor(my_array)

    ct_add_section("signature")
        ct_add_section("Arg1: array")
            _cpp_array_bounds_check(TRUE a_value)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Arg2: int")
            _cpp_array_bounds_check("${my_array}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is int")
        ct_end_section()
    ct_end_section()

    ct_add_section("Has no values")
        ct_add_section("Equal to length")
            _cpp_array_bounds_check("${my_array}" 0)
            ct_assert_fails_as("Assertion: 0 < 0")
        ct_end_section()

        ct_add_section("Greater than length")
            _cpp_array_bounds_check("${my_array}" 1)
            ct_assert_fails_as("Assertion: 1 < 0")
        ct_end_section()
    ct_end_section()

    ct_add_section("Has one value")
        _cpp_array_append("${my_array}" "a_value")
        _cpp_array_bounds_check("${my_array}" 0)

        ct_add_section("Equal to length")
            _cpp_array_bounds_check("${my_array}" 1)
            ct_assert_fails_as("Assertion: 1 < 1")
        ct_end_section()

        ct_add_section("Greater than length")
            _cpp_array_bounds_check("${my_array}" 2)
            ct_assert_fails_as("Assertion: 2 < 1")
        ct_end_section()
    ct_end_section()

ct_end_test()
