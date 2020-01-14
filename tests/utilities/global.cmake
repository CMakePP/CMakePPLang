include(cmake_test/cmake_test)

ct_add_test("cpp_append_global")
    include(cmakepp_core/utilities/global)

    ct_add_section("Signature")
        cpp_append_global(a_key true 42)
        ct_assert_fails_as("cpp_append_global accepts exactly 2 arguments.")
    ct_end_section()

    ct_add_section("Non-existing variable")
        cpp_append_global(a_key 42)
        cpp_get_global(result a_key)
        ct_assert_equal(result 42)
    ct_end_section()

    ct_add_section("Existing variable")
        include(cmakepp_core/utilities/compare_lists)
        cpp_append_global(a_key foo)
        cpp_append_global(a_key bar)
        cpp_get_global(value a_key)
        set(corr foo bar)
        cpp_compare_lists(result corr value)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Is case-insensitive")
        cpp_append_global(a_key foo)
        cpp_get_global(result A_KEY)
        ct_assert_equal(result foo)
    ct_end_section()
ct_end_test()

ct_add_test("cpp_set_global")
    include(cmakepp_core/utilities/global)

    ct_add_section("Signature")
        cpp_set_global(a_key true 42)
        ct_assert_fails_as("cpp_set_global accepts exactly 2 arguments.")
    ct_end_section()

    ct_add_section("Non-existing variable")
        cpp_set_global(a_key 42)
        cpp_get_global(result a_key)
        ct_assert_equal(result 42)
    ct_end_section()

    ct_add_section("Overwrites existing variable")
        cpp_set_global(a_key foo)
        cpp_set_global(a_key bar)
        cpp_get_global(result a_key)
        ct_assert_equal(result bar)
    ct_end_section()

    ct_add_section("Is case-insensitive")
        cpp_set_global(a_key foo)
        cpp_get_global(result A_KEY)
        ct_assert_equal(result foo)
    ct_end_section()
ct_end_test()

ct_add_test("cpp_get_global")
    include(cmakepp_core/utilities/global)

    ct_add_section("Signature")
        cpp_get_global(result a_key 42)
        ct_assert_fails_as("cpp_get_global accepts exactly 2 arguments.")
    ct_end_section()

    ct_add_section("Get non-existing variable")
        cpp_get_global(result a_key)
        ct_assert_equal(result "")
    ct_end_section()
ct_end_test()