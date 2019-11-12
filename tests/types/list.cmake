include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_list,  cpp_is_not_list, and
# cpp_assert_list is contained within cpp_is_list. cpp_is_not_list simply
# negates cpp_is_list's result and thus it suffices to test the negation.
# cpp_assert_list combines a call to cpp_is_list with an assert and it thus
# suffices to test that the assertion is tripped correctly.
#]]

ct_add_test("cpp_is_list")
    include(cmakepp_core/types/list)

    ct_add_section("empty string")
        cpp_is_list(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        cpp_is_list(return "Hello World")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("bool")
        cpp_is_list(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_list(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_list(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_list(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("filepath")
        cpp_is_list(return "${CMAKE_BINARY_DIR}")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        cpp_is_list(return "1;2;3")
        ct_assert_equal(return TRUE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_list")
    include(cmakepp_core/types/list)

    ct_add_section("is a list")
        cpp_is_not_list(result "1;2;3")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("is not a list")
        cpp_is_not_list(result "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_list")
    include(cmakepp_core/types/list)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("not a list")
        cpp_assert_list("Hello World")
        ct_assert_fails_as("Assertion: 'Hello World' is a list")
    ct_end_section()

    ct_add_section("is a list")
        cpp_assert_list("1;2;3")
    ct_end_section()
ct_end_test()
