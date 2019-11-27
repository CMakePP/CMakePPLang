include(cmake_test/cmake_test)

ct_add_test("_cpp_generate_header")
    include(cmakepp_core/function/detail_/generate_header)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Argument 1 must be a desc")
            _cpp_generate_header(TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Can only pass 1 argument")
            _cpp_generate_header(result TRUE)
            ct_assert_fails_as("Function takes 1 argument(s), but 2 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("returns the correct value")
        _cpp_generate_header(result)
        set(corr "include_guard()\ninclude(cmakepp_core/asserts/signature)\n\n")
        ct_assert_equal(result "${corr}")
    ct_end_section()
ct_end_test()
