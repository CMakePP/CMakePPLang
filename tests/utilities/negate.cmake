include(cmake_test/cmake_test)

ct_add_test("negate")
    include(cmakepp_core/utilities/negate)

    ct_add_section("TRUE value")
        cpp_negate(result TRUE)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("FALSE value")
        cpp_negate(result FALSE)
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
