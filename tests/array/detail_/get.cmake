include(cmake_test/cmake_test)

ct_add_test("_cpp_array_get")
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/array/detail_/append)
    include(cmakepp_core/array/detail_/get)

    set(CMAKEPP_CORE_DEBUG_MODE ON)
    _cpp_array_ctor(my_array)
    _cpp_array_append("${my_array}" a_value another_value)

    ct_add_section("signature")
        ct_add_section("Arg1: desc")
            _cpp_array_get(TRUE "${my_array}" 0)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: array")
            _cpp_array_get(result TRUE 0)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Arg3: int")
            _cpp_array_get(result "${my_array}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is int")
        ct_end_section()
    ct_end_section()

    ct_add_section("In-bounds elements")
        _cpp_array_get(result "${my_array}" 0)
        ct_assert_equal(result a_value)

        _cpp_array_get(result "${my_array}" 1)
        ct_assert_equal(result another_value)
    ct_end_section()

    ct_add_section("Fails if element is out of range")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_array_get(result "${my_array}" 42)
        ct_assert_fails_as("Assertion: 42 < 2")
    ct_end_section()
ct_end_test()
