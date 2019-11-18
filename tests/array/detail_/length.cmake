include(cmake_test/cmake_test)

ct_add_test("_cpp_array_length")
    include(cmakepp_core/array/detail_/append)
    include(cmakepp_core/array/detail_/ctor)
    include(cmakepp_core/array/detail_/length)

    _cpp_array_ctor(my_array)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: desc")
            _cpp_array_length(TRUE "${my_array}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: array")
            _cpp_array_length(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()
    ct_end_section()

    ct_add_section("No elements")
        _cpp_array_length(result "${my_array}")
        ct_assert_equal(result 0)
    ct_end_section()

    ct_add_section("One element")
        _cpp_array_append("${my_array}" 0)
        _cpp_array_length(result "${my_array}")
        ct_assert_equal(result 1)

        ct_add_section("Two elements")
            _cpp_array_append("${my_array}" 1)
            _cpp_array_length(result "${my_array}")
            ct_assert_equal(result 2)
        ct_end_section()
    ct_end_section()

ct_end_test()
