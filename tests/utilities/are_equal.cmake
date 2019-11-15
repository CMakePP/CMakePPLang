include(cmake_test/cmake_test)

ct_add_test("cpp_are_equal")
    include(cmakepp_core/utilities/are_equal)

    ct_add_section("LHS == RHS")
        cpp_are_equal(result "Hello World" "Hello World")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("LHS != RHS")
        cpp_are_equal(result "Hello World" 42)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
