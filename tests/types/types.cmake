include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# types.cmake brings together all of the logic in the types directory.
# cpp_is_type dispatches to the appropriate cpp_is_* based on the provided type.
# We know the various cpp_is_* work thanks to unit-testing so all we need to
# ensure is that cpp_is_type correctly dispatches. This is easiest done by
# providing it (type, string)-pairs that are true (for each string there should
# be only one way to get true, but multiple ways to get false). cpp_is_not_type
# simply negates the results so it suffices to test that they are properly
# negated for a single true (type, string)-pair and a single false
# (type, string)-pair. Similarly, cpp_assert_type works by asserting the result
# of a call to cpp_is_type are true, so it again suffices to only consider a
# single true and a single false pair.
#]]

ct_add_test("cpp_is_type")
    include(cmakepp_core/types/types)

    ct_add_section("bool")
        cpp_is_type(return bool TRUE)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("description")
        cpp_is_type(return desc "Hello World")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("int")
        cpp_is_type(return int 42)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_type(return float 3.14)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_type(return target lib)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("filepath")
        cpp_is_type(return filepath "${CMAKE_BINARY_DIR}")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("list")
        cpp_is_type(return list "1;2;3")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("unrecognized type")
        cpp_is_type(return "not_a_type" TRUE)
        ct_assert_fails_as("not_a_type is not a recognized CMake type.")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_is_not_type")
    include(cmakepp_core/types/types)

    ct_add_section("is that type")
        cpp_is_not_type(result list "1;2;3")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("is not that type")
        cpp_is_not_type(result bool "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_type")
    include(cmakepp_core/types/types)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("odd number of arguments")
        cpp_assert_type(desc)
        ct_assert_fails_as("cpp_assert_type takes an even number of arguments.")
    ct_end_section()

    ct_add_section("no arguments")
        cpp_assert_type()
    ct_end_section()

    ct_add_section("2 arguments")
        cpp_assert_type(desc "hello world")
    ct_end_section()

    ct_add_section("4 arguments")
        cpp_assert_type(desc "hello world" list "1;2;3")
    ct_end_section()

    ct_add_section("6 arguments")
        cpp_assert_type(desc "hello world" list "1;2;3" bool TRUE)
    ct_end_section()

    ct_add_section("Fails assertion")
        cpp_assert_type(desc 1)
        ct_assert_fails_as("1 is desc")
    ct_end_section()
ct_end_test()
