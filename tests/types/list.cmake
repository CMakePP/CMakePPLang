include(cmake_test/cmake_test)

ct_add_test("cpp_is_list")
    include(cmakepp_core/types/list)

    ct_add_section("bool")
        cpp_is_list(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")

        ct_add_section("description w/o a list")
            cpp_is_list(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing escaped semicolons")
            cpp_is_list(return "Hello World 1\\\;2\\\;3")
            ct_assert_equal(return FALSE)
        ct_end_section()

    ct_end_section()

    ct_add_section("float")
        cpp_is_list(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_list(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            cpp_is_list(return "1;2;3")
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("List of lists")
            cpp_is_list(return "TRUE\\\;FALSE;FALSE\\\;TRUE")
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("path")
        ct_add_section("Normal filepath (probably)")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Contains a semicolon (please don't do this either)")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}/hello\\\;world")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_list(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

ct_end_test()
