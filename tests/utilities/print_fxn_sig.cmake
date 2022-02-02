include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_print_fxn_sig")
function("${test_cpp_print_fxn_sig}")
    include(cmakepp_core/utilities/print_fxn_sig)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_desc" EXPECTFAIL)
        function("${first_arg_desc}")
            cpp_print_fxn_sig(TRUE a_fxn)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            cpp_print_fxn_sig(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "no_arguments")
    function("${no_arguments}")
        cpp_print_fxn_sig(result a_fxn)
        ct_assert_equal(result "a_fxn()")
    endfunction()

    ct_add_section(NAME "one_argument")
    function("${one_argument}")
        cpp_print_fxn_sig(result a_fxn int)
        ct_assert_equal(result "a_fxn(int)")
    endfunction()

    ct_add_section(NAME "two_arguments")
    function("${two_arguments}")
        cpp_print_fxn_sig(result a_fxn int bool)
        ct_assert_equal(result "a_fxn(int, bool)")
    endfunction()
endfunction()
