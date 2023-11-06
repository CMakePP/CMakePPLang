include(cmake_test/cmake_test)

#[[
# For sections which have no CMakeTest assertions, we are basically just making
# sure the function runs without problem. Also we don't have to test for the
# case where the user passed fewer than the required number of positional
# arguments as CMake will catch that one for us.
#]]

ct_add_test(NAME [[_test_cpp_assert_signature]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/asserts/signature)
    set(CMAKEPP_LANG_DEBUG_MODE ON)

    ct_add_section(NAME [[sig_nonvariadic]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[sig_nonvariadic_noargs]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("")
        endfunction()

        ct_add_section(NAME [[sig_nonvariadic_one_arg]])
        function("${CMAKETEST_SECTION}")
            ct_add_section(NAME [[sig_correct_type]])
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE" bool)
            endfunction()

            ct_add_section(NAME [[sig_wrong_type]] EXPECTFAIL)
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE" int)
            endfunction()

            ct_add_section(NAME [[sig_too_many_args]] EXPECTFAIL)
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE;FALSE" bool)
            endfunction()
        endfunction()

        ct_add_section(NAME [[sig_nonvariadic_two_args]])
        function("${CMAKETEST_SECTION}")
            ct_add_section(NAME [[sig_both_correct_type]])
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE;42" bool int)
            endfunction()

            ct_add_section(NAME [[sig_first_arg_wrong_type]] EXPECTFAIL)
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE;42" int int)
            endfunction()

            ct_add_section(NAME [[sig_second_arg_wrong_type]] EXPECTFAIL)
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE;TRUE" bool int)
            endfunction()

            ct_add_section(NAME [[sig_too_many_args]] EXPECTFAIL)
            function("${CMAKETEST_SECTION}")
                cpp_assert_signature("TRUE;42;FALSE" bool int)
            endfunction()
        endfunction()
    endfunction()  # Set number of arguments

    ct_add_section(NAME [[sig_variadic]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[sig_variadic_noargs]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("" args)
        endfunction()

        ct_add_section(NAME [[sig_variadic_one_arg]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE" args)
        endfunction()

        ct_add_section(NAME [[sig_variadic_two_args]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE;42" args)
        endfunction()
    endfunction()

    ct_add_section(NAME [[sig_variadic_one_positional_and_variadic]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[sig_one_arg_right_type]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42" int args)
        endfunction()

        ct_add_section(NAME [[sig_one_arg_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE" int args)
        endfunction()

        ct_add_section(NAME [[sig_two_args_right_type]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42;TRUE" int args)
        endfunction()

        ct_add_section(NAME [[sig_two_args_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE;TRUE" int args)
        endfunction()
    endfunction()

    ct_add_section(NAME [[sig_two_pos_args_and_varargs]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[sig_two_args_right_type]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42;TRUE" int bool args)
        endfunction()

        ct_add_section(NAME [[sig_two_args_first_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE;TRUE" int bool args)
        endfunction()

        ct_add_section(NAME [[sig_two_args_second_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42;42" int bool args)
        endfunction()

        ct_add_section(NAME [[sig_three_args_right_type]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42;TRUE;hello" int bool args)
        endfunction()

        ct_add_section(NAME [[sig_three_args_first_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("TRUE;TRUE;hello" int bool args)
        endfunction()

        ct_add_section(NAME [[sig_three_args_second_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("42;42;hello" int bool args)
        endfunction()
    endfunction()

    ct_add_section(NAME [[sig_str_arg]])
    function("${CMAKETEST_SECTION}")
        cpp_assert_signature("42" str)
    endfunction()

    ct_add_section(NAME [[sig_object]])
    function("${CMAKETEST_SECTION}")
        include(cmakepp_lang/object/object)
        cpp_assert_signature("${__CMAKEPP_LANG_OBJECT_SINGLETON__}" obj)
    endfunction()

    ct_add_section(NAME [[sig_double_variadic_signature]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_assert_signature("TRUE;42;FALSE" bool args args)
    endfunction()

    ct_add_section(NAME [[sig_pointer]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[sig_pointer_bool]])
        function("${CMAKETEST_SECTION}")
            set(_spb_pointer TRUE)
            cpp_assert_signature("_spb_pointer" bool*)
        endfunction()

        ct_add_section(NAME [[sig_pointer_to_desc]])
        function("${CMAKETEST_SECTION}")
            set(_sptd_pointer TRUE)
            cpp_assert_signature("_sptd_pointer" desc)
        endfunction()


        # Potentially dangerous case to support
        # Since we can't verify that the desc actually resolves
        # to a value, we could end up with weird empty results upon dereferencing
        # But, same goes for using a null pointer in other languages, so
        # at least it's consistent
        ct_add_section(NAME [[sig_desc_to_pointer]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_signature("_sdtp_pointer" bool*)
        endfunction()

    endfunction()

endfunction()
