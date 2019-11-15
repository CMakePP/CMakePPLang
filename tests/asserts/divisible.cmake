include(cmake_test/cmake_test)

ct_add_test("cpp_assert_divisible")
    include(cmakepp_core/asserts/divisible)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("is divisible")
        cpp_assert_divisible(4 2)
    ct_end_section()

    ct_add_section("is not divisible")
        cpp_assert_divisible(4 3)
        ct_assert_fails_as("Assertion: 4 % 3 == 0")
    ct_end_section()

    ct_add_section("Fails if not integers")
        cpp_assert_divisible(TRUE 2)
        ct_assert_fails_as("Assertion: TRUE is int")
    ct_end_section()
ct_end_test()
