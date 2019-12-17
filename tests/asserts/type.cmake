include(cmake_test/cmake_test)

ct_add_test("cpp_assert_type")
    include(cmakepp_core/asserts/type)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("Built-in Types")

        ct_add_section("Same type")
            cpp_assert_type(int 1)
        ct_end_section()

        ct_add_section("Wrong type")
            cpp_assert_type(int TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()
    ct_end_section()

ct_end_test()
