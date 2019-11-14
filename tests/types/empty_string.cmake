include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic of cpp_is_empty_string and
# cpp_is_not_empty_string is contained within cpp_is_empty_string; the latter
# simply negates the former's result. Hence our testing strategy is to make sure
# that cpp_is_empty_string only triggers on an empty_string string and to test
# that cpp_is_not_empty_string properly negates results.
#]]

ct_add_test("cpp_is_empty_string")
    include(cmakepp_core/types/empty_string)

    ct_add_section("empty string")
        cpp_is_empty_string(return "")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("string")
        cpp_is_empty_string(return "Hello World")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("bool")
        cpp_is_empty_string(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_empty_string(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_empty_string(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_empty_string(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("file path")
        cpp_is_empty_string(return "hello/world")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        cpp_is_empty_string(return "[[1;2;3]]")
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()

ct_add_test("cpp_is_not_empty_string")
    include(cmakepp_core/types/empty_string)

    ct_add_section("empty string")
        cpp_is_not_empty_string(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("non-empty")
        cpp_is_not_empty_string(return "Hello World")
        ct_assert_equal(return TRUE)
    ct_end_section()
ct_end_test()
