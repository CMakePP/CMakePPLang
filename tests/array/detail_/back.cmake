include(cmake_test/cmake_test)

ct_add_test("_cpp_array_back")
    include(cmakepp_core/array/detail_/back)
    include(cmakepp_core/array/detail_/ctor)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_array_ctor(an_array)

        ct_add_section("Arg1 must be desc")
            _cpp_array_back(TRUE "${an_array}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be array")
            _cpp_array_back(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Takes two arguments")
            _cpp_array_back(result "${an_array}" hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Fails if empty")
        _cpp_array_ctor(an_array)
        _cpp_array_back(result "${an_array}")
        ct_assert_fails_as("Assertion: Array is non-empty")
    ct_end_section()

    ct_add_section("1 element")
        _cpp_array_ctor(an_array 0)
        _cpp_array_back(result "${an_array}")
        ct_assert_equal(result 0)
    ct_end_section()

    ct_add_section("2 elements")
        _cpp_array_ctor(an_array 0 foo)
        _cpp_array_back(result "${an_array}")
        ct_assert_equal(result foo)
    ct_end_section()
ct_end_test()
