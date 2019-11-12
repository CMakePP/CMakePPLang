include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_bool, cpp_is_not_bool, and
# cpp_assert_bool is contained within cpp_is_bool. cpp_is_not_bool simply
# negates cpp_is_bool's result and thus it suffices to test the negation.
# cpp_assert_bool combines a call to cpp_is_bool with an assert and it thus
# suffices to test that the assertion is tripped correctly.
#]]

ct_add_test("cpp_is_bool")
    include(cmakepp_core/types/bool)

    ct_add_section("empty string")
        cpp_is_bool(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        ct_add_section("non-empty string with bool")
            cpp_is_bool(return "Hello World TRUE")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("whitespace string with bool")
            cpp_is_bool(return " TRUE")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("bool")
        ct_add_section("ON")
            cpp_is_bool(return ON)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("YES")
            cpp_is_bool(return yes)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("TRUE")
            cpp_is_bool(return tRuE)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("Y")
            cpp_is_bool(return Y)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("OFF")
            cpp_is_bool(return OFF)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("NO")
            cpp_is_bool(return NO)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("FALSE")
            cpp_is_bool(return FALSE)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("N")
            cpp_is_bool(return N)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("NOTFOUND")
            cpp_is_bool(return NOTFOUND)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("integer")
        cpp_is_bool(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_bool(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target (with bool)")
        add_library(libTRUE STATIC IMPORTED)
        cpp_is_bool(return libTRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("file path (with bool)")
        cpp_is_bool(return "hello/worldTRUE")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list (of bools)")
        cpp_is_bool(return "TRUE;FALSE")
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_bool")
    include(cmakepp_core/types/bool)

    ct_add_section("not a bool")
        cpp_is_not_bool(return "Hello World")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("is a bool")
        cpp_is_not_bool(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_bool")
    include(cmakepp_core/types/bool)
    set(CMAKEPP_CORE_DEBUG_MODE ON)
    ct_add_section("is bool")
        cpp_assert_bool(TRUE)
    ct_end_section()

    ct_add_section("is not bool")
        cpp_assert_bool("hello world")
        ct_assert_fails_as("Assertion: hello world is bool")
    ct_end_section()
ct_end_test()
