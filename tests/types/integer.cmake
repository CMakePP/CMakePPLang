include(cmake_test/cmake_test)

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

    ct_add_section("empty string")
        cpp_is_not_int(return "")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("string")
        ct_add_section("non-empty string with int")
            cpp_is_not_int(return "Hello World2")
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("whitespace string with int")
            cpp_is_not_int(return " 2")
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("bool (not 0 or 1)")
        cpp_is_not_int(return TRUE)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("integer")
        ct_add_section("Positive integer")
            cpp_is_not_int(return 42)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Negative integer")
            cpp_is_not_int(return -42)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        cpp_is_not_int(return 3.14)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("target (with int)")
        add_library(lib2 STATIC IMPORTED)
        cpp_is_not_int(return lib2)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("file path (with int)")
        cpp_is_not_int(return "hello/world2")
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("list (of ints)")
        cpp_is_not_int(return "1;2;3")
        ct_assert_equal(return TRUE)
    ct_end_section()

ct_end_test()
