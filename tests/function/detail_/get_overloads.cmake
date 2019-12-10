include(cmake_test/cmake_test)

ct_add_test("_cpp_function_get_overloads")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/function/detail_/get_overloads)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            _cpp_function_get_overloads(TRUE a_fxn)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_function_get_overloads(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes two arguments")
            _cpp_function_get_overloads(result a_fxn hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    cpp_map(CTOR corr)

    ct_add_section("overload does not exist")
        _cpp_function_get_overloads(a_fxn result)

        ct_add_section("Result is a different instance")
            ct_assert_not_equal(result "${corr}")
        ct_end_section()

        ct_add_section("Result has correct value")
            cpp_equal(result "${result}" "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("overload already exists")
        cpp_set_global(a_fxn_overloads "${corr}")
        _cpp_function_get_overloads(a_fxn result)
        ct_assert_equal(result "${corr}")
    ct_end_section()
ct_end_test()
