include(cmake_test/cmake_test)

ct_add_test("cpp_unique_id")
    include(cmakepp_core/utilities/unique_id)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be desc")
            cpp_unique_id(TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Only accepts one argument")
            cpp_unique_id(result hello)
            ct_assert_fails_as("Function takes 1 argument(s), but 2 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Rapidly generated ids are unique")
        cpp_unique_id(result0)
        cpp_unique_id(result1)
        cpp_unique_id(result2)
        ct_assert_not_equal(result0 "${result1}")
        ct_assert_not_equal(result0 "${result2}")
        ct_assert_not_equal(result1 "${result2}")
    ct_end_section()
ct_end_test()
