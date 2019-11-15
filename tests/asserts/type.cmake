include(cmake_test/cmake_test)

ct_add_test("cpp_assert_type")
    include(cmakepp_core/asserts/type)
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
