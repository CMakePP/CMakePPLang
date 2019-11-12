include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# For the most part all of the logic for cpp_is_absolute_filepath, 
# cpp_is_not_absolute_filepath, and cpp_assert_absolute_filepath is contained 
# within cpp_is_absolute_filepath. cpp_is_not_absolute_filepath simply
# negates cpp_is_absolute_filepath's result and thus it suffices to test the 
# negation. cpp_assert_absolute_filepath combines a call to 
# cpp_is_absolute_filepath with an assert and it thus suffices to test that the 
#assertion is tripped correctly.
#]]

ct_add_test("cpp_is_absolute_filepath")
    include(cmakepp_core/types/filepath)

    ct_add_section("empty string")
        cpp_is_absolute_filepath(return "")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("string")
        cpp_is_absolute_filepath(return "Hello World")
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("bool")
        cpp_is_absolute_filepath(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_absolute_filepath(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("float")
        cpp_is_absolute_filepath(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_absolute_filepath(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("filepath")
        ct_add_section("absolute")
            cpp_is_absolute_filepath(return "${CMAKE_BINARY_DIR}")
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("relative")
            cpp_is_absolute_filepath(return "a/directory")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("list (of filepaths)")
        cpp_is_absolute_filepath(
            return "[[${CMAKE_BINARY_DIR};${CMAKE_CURRENT_LIST_DIR}]]"
        )
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_is_not_absolute_filepath")
    include(cmakepp_core/types/filepath)

    ct_add_section("is filepath")
        cpp_is_not_absolute_filepath(result "${CMAKE_CURRENT_LIST_DIR}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("is not filepath")
        cpp_is_not_absolute_filepath(result "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()

ct_add_test("cpp_assert_filepath")
    include(cmakepp_core/types/filepath)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("not a filepath")
        cpp_assert_absolute_filepath("Hello World")
        ct_assert_fails_as("Assertion: 'Hello World' is an absolute filepath")
    ct_end_section()

    ct_add_section("is a filepath")
        cpp_assert_absolute_filepath(${CMAKE_CURRENT_LIST_DIR})
    ct_end_section()
ct_end_test()
