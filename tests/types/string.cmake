include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic of cpp_is_empty and cpp_is_not_empty is
# contained within cpp_is_empty; the latter simply negates the former's result.
# Hence our testing strategy is to make sure that cpp_is_empty only triggers on
# an empty string and to test that cpp_is_not_empty properly negates results.
#]]

ct_add_test("cpp_is_empty")
    include(cmakepp_core/types/string)

    ct_add_section("empty string")
        cpp_is_empty(return "")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("string")
        cpp_is_empty(return "Hello World")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("bool")
        cpp_is_empty(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_empty(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_empty(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_empty(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("file path")
        cpp_is_empty(return "hello/world")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        cpp_is_empty(return "[[1;2;3]]")
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()

ct_add_test("cpp_is_not_empty")
    include(cmakepp_core/types/string)

    ct_add_section("empty string")
        cpp_is_not_empty(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("non-empty")
        cpp_is_not_empty(return "Hello World")
        ct_assert_equal(return TRUE)
    ct_end_section()
ct_end_test()
