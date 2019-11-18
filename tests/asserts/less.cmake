include(cmake_test/cmake_test)

ct_add_test("cpp_assert_less")
    include(cmakepp_core/asserts/less)
    set(CMAKEPP_CORE_DEBUG_MODE ON)
    ct_add_section("is greater than")
        cpp_assert_less(4 2)
        ct_assert_fails_as("Assertion: 4 < 2")
    ct_end_section()

    ct_add_section("is equal")
        cpp_assert_less(4 4)
        ct_assert_fails_as("Assertion: 4 < 4")
    ct_end_section()

    ct_add_section("less than")
        cpp_assert_less(3 4)
    ct_end_section()

    ct_add_section("Fails if not integers")
        cpp_assert_less(TRUE 4)
        ct_assert_fails_as("Assertion: TRUE is int")
    ct_end_section()
ct_end_test()
