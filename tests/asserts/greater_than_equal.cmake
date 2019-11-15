include(cmake_test/cmake_test)

ct_add_test("cpp_assert_greater_than_equal")
    include(cmakepp_core/asserts/greater_than_equal)
    set(CMAKEPP_CORE_DEBUG_MODE ON)
    ct_add_section("is greater than")
        cpp_assert_greater_than_equal(4 2)
    ct_end_section()

    ct_add_section("is equal")
        cpp_assert_greater_than_equal(4 4)
    ct_end_section()

    ct_add_section("Fails if less than")
        cpp_assert_greater_than_equal(3 4)
        ct_assert_fails_as("Assertion: 3 >= 4")
    ct_end_section()

    ct_add_section("Fails if not integers")
        cpp_assert_greater_than_equal(TRUE 4)
        ct_assert_fails_as("Assertion: TRUE is int")
    ct_end_section()
ct_end_test()
