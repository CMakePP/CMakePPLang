include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_target, cpp_is_not_target, and
# cpp_assert_target is contained within cpp_is_target. cpp_is_not_target simply
# negates cpp_is_target's result and thus it suffices to test the negation.
# cpp_assert_target combines a call to cpp_is_target with an assert and it thus
# suffices to test that the assertion is tripped correctly.
#]]

ct_add_test("cpp_is_target")
    include(cmakepp_core/types/target)

    ct_add_section("empty string")
        cpp_is_target(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        cpp_is_target(return "Hello World")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("bool")
        cpp_is_target(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_target(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_target(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_target(return lib)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("file path")
        cpp_is_target(return "hello/world")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list (of targets)")
        add_library(lib STATIC IMPORTED)
        add_library(lib2 STATIC IMPORTED)
        cpp_is_target(return "[[lib;lib2]]")
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_target")
    include(cmakepp_core/types/target)

    ct_add_section("is target")
        add_library(lib STATIC IMPORTED)
        cpp_is_not_target(result lib)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("is not target")
        cpp_is_not_target(result "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_target")
    include(cmakepp_core/types/target)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("not a target")
        cpp_assert_target("Hello World")
        ct_assert_fails_as("Assertion: 'Hello World' is a target")
    ct_end_section()

    ct_add_section("is a target")
        add_library(lib STATIC IMPORTED)
        cpp_assert_target(lib)
    ct_end_section()
ct_end_test()
