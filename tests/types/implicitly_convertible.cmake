include(cmake_test/cmake_test)

ct_add_test("cpp_implicitly_convertible")
    include(cmakepp_core/types/implicitly_convertible)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            cpp_implicitly_convertible(TRUE int int)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be type")
            cpp_implicitly_convertible(result TRUE int)
            ct_assert_fails_as("Assertion: TRUE is type")
        ct_end_section()

        ct_add_section("Arg3 must be type")
            cpp_implicitly_convertible(result int TRUE)
            ct_assert_fails_as("Assertion: TRUE is type")
        ct_end_section()

        ct_add_section("Function takes 3 arguments")
            cpp_implicitly_convertible(result int int hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Not convertible")
        cpp_implicitly_convertible(result int bool)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Same types are convertible")
        cpp_implicitly_convertible(result int int)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Everything can convert to str")
        cpp_implicitly_convertible(result str array)
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
