include(cmake_test/cmake_test)

ct_add_test("cpp_print_fxn_sig")
    include(cmakepp_core/utilities/print_fxn_sig)

    ct_add_section("No arguments")
        cpp_print_fxn_sig(result a_fxn)
        ct_assert_equal(result "a_fxn()")
    ct_end_section()

    ct_add_section("One argument")
        cpp_print_fxn_sig(result a_fxn int)
        ct_assert_equal(result "a_fxn(int)")
    ct_end_section()

    ct_add_section("Two arguments")
        cpp_print_fxn_sig(result a_fxn int bool)
        ct_assert_equal(result "a_fxn(int, bool)")
    ct_end_section()
ct_end_test()
