include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_float, cpp_is_not_float, and
# cpp_assert_float is contained within cpp_is_float. cpp_is_not_float simply
# negates cpp_is_float's result and thus it suffices to test the negation.
# cpp_assert_float combines a call to cpp_is_float with an assert and it thus
# suffices to test that the assertion is tripped correctly.
#]]

ct_add_test("cpp_is_float")
    include(cmakepp_core/types/float)

    ct_add_section("empty string")
        cpp_is_float(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        ct_add_section("non-empty string with float")
            cpp_is_float(return "Hello World3.14")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("whitespace string with float")
            cpp_is_float(return " 3.14")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("bool")
        cpp_is_float(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_float(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        ct_add_section("positive")
            cpp_is_float(return 3.14)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("negative")
            cpp_is_float(return -3.14)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target (with float)")
        add_library(lib3.14 STATIC IMPORTED)
        cpp_is_float(return lib3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("file path (with float)")
        cpp_is_float(return "hello/world3.14")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list (of floats)")
        cpp_is_float(return "3.14;6.23")
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_float")
    include(cmakepp_core/types/float)

    ct_add_section("is float")
        cpp_is_not_float(result 3.14)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("is not float")
        cpp_is_not_float(result "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()

ct_add_test("cpp_assert_float")
    include(cmakepp_core/types/float)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("not a float")
        cpp_assert_float("Hello World")
        ct_assert_fails_as("Assertion: 'Hello World' is a float")
    ct_end_section()

    ct_add_section("is a float")
        cpp_assert_float(3.14)
    ct_end_section()
ct_end_test()
