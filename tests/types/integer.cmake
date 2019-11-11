include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_int, cpp_is_not_int, and
# cpp_assert_int is contained within cpp_is_int. cpp_is_not_int simply negates
# cpp_is_int's result and thus it suffices to test the negation. cpp_assert_int
# combines a call to cpp_is_int with an assert and it thus suffices to test that
# the assertion is tripped correctly.
#]]

ct_add_test("cpp_is_int")
    include(cmakepp_core/types/integer)

    ct_add_section("empty string")
        cpp_is_int(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        ct_add_section("non-empty string with int")
            cpp_is_int(return "Hello World2")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("whitespace string with int")
            cpp_is_int(return " 2")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("bool (not 0 or 1)")
        cpp_is_int(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        ct_add_section("Positive integer")
            cpp_is_int(return 42)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("Negative integer")
            cpp_is_int(return -42)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        cpp_is_int(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target (with int)")
        add_library(lib2 STATIC IMPORTED)
        cpp_is_int(return lib2)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("file path (with int)")
        cpp_is_int(return "hello/world2")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list (of ints)")
        cpp_is_int(return "1;2;3")
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_int")
    include(cmakepp_core/types/integer)

    ct_add_section("is not an integer")
        cpp_is_not_int(return TRUE)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("is an integer")
        cpp_is_not_int(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_int")
    include(cmakepp_core/types/integer)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("not an int")
        cpp_assert_int(TRUE)
        ct_assert_fails_as("Assertion: 'TRUE' is an integer")
    ct_end_section()

    ct_add_section("is an integer")
        cpp_assert_int(42)
    ct_end_section()

ct_end_test()
