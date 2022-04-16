include(cmake_test/cmake_test)

#[[
# For sections which have no CMakeTest assertions, we are basically just making
# sure the function runs without problem. Also we don't have to test for the
# case where the user passed fewer than the required number of positional
# arguments as CMake will catch that one for us.
#]]

ct_add_test(NAME "_test_cpp_assert_signature")
function(${_test_cpp_assert_signature})
    include(cmakepp_lang/asserts/signature)
    set(CMAKEPP_LANG_DEBUG_MODE ON)

    ct_add_section(NAME "sig_nonvariadic")
    function(${sig_nonvariadic})
        ct_add_section(NAME "sig_nonvariadic_noargs")
        function(${sig_nonvariadic_noargs})
            cpp_assert_signature("")
        endfunction()

        ct_add_section(NAME "sig_nonvariadic_one_arg")
        function(${sig_nonvariadic_one_arg})
            ct_add_section(NAME "sig_correct_type")
            function(${sig_correct_type})
                cpp_assert_signature("TRUE" bool)
            endfunction()

            ct_add_section(NAME "sig_wrong_type" EXPECTFAIL)
            function(${sig_wrong_type})
                cpp_assert_signature("TRUE" int)
            endfunction()

            ct_add_section(NAME "sig_too_many_args" EXPECTFAIL)
            function(${sig_too_many_args})
                cpp_assert_signature("TRUE;FALSE" bool)
            endfunction()
        endfunction()

        ct_add_section(NAME "sig_nonvariadic_two_args")
        function(${sig_nonvariadic_two_args})
            ct_add_section(NAME "sig_both_correct_type")
            function(${sig_both_correct_type})
                cpp_assert_signature("TRUE;42" bool int)
            endfunction()

            ct_add_section(NAME "sig_first_arg_wrong_type" EXPECTFAIL)
            function(${sig_first_arg_wrong_type})
                cpp_assert_signature("TRUE;42" int int)
            endfunction()

            ct_add_section(NAME "sig_second_arg_wrong_type" EXPECTFAIL)
            function(${sig_second_arg_wrong_type})
                cpp_assert_signature("TRUE;TRUE" bool int)
            endfunction()

            ct_add_section(NAME "sig_too_many_args" EXPECTFAIL)
            function(${sig_too_many_args})
                cpp_assert_signature("TRUE;42;FALSE" bool int)
            endfunction()
        endfunction()
    endfunction()  # Set number of arguments

    ct_add_section(NAME "sig_variadic")
    function(${sig_variadic})
        ct_add_section(NAME "sig_variadic_noargs")
        function(${sig_variadic_noargs})
            cpp_assert_signature("" args)
        endfunction()

        ct_add_section(NAME "sig_variadic_one_arg")
        function(${sig_variadic_one_arg})
            cpp_assert_signature("TRUE" args)
        endfunction()

        ct_add_section(NAME "sig_variadic_two_args")
        function(${sig_variadic_two_args})
            cpp_assert_signature("TRUE;42" args)
        endfunction()
    endfunction()

    ct_add_section(NAME "sig_variadic_one_positional_and_variadic")
    function(${sig_variadic_one_positional_and_variadic})
        ct_add_section(NAME "sig_one_arg_right_type")
        function(${sig_one_arg_right_type})
            cpp_assert_signature("42" int args)
        endfunction()

        ct_add_section(NAME "sig_one_arg_wrong_type" EXPECTFAIL)
        function(${sig_one_arg_wrong_type})
            cpp_assert_signature("TRUE" int args)
        endfunction()

        ct_add_section(NAME "sig_two_args_right_type")
        function(${sig_two_args_right_type})
            cpp_assert_signature("42;TRUE" int args)
        endfunction()

        ct_add_section(NAME "sig_two_args_wrong_type" EXPECTFAIL)
        function(${sig_two_args_wrong_type})
            cpp_assert_signature("TRUE;TRUE" int args)
        endfunction()
    endfunction()

    ct_add_section(NAME "sig_two_pos_args_and_varargs")
    function(${sig_two_pos_args_and_varargs})
        ct_add_section(NAME "sig_two_args_right_type")
        function(${sig_two_args_right_type})
            cpp_assert_signature("42;TRUE" int bool args)
        endfunction()

        ct_add_section(NAME "sig_two_args_first_wrong_type" EXPECTFAIL)
        function(${sig_two_args_first_wrong_type})
            cpp_assert_signature("TRUE;TRUE" int bool args)
        endfunction()

        ct_add_section(NAME "sig_two_args_second_wrong_type" EXPECTFAIL)
        function(${sig_two_args_second_wrong_type})
            cpp_assert_signature("42;42" int bool args)
        endfunction()

        ct_add_section(NAME "sig_three_args_right_type")
        function(${sig_three_args_right_type})
            cpp_assert_signature("42;TRUE;hello" int bool args)
        endfunction()

        ct_add_section(NAME "sig_three_args_first_wrong_type" EXPECTFAIL)
        function(${sig_three_args_first_wrong_type})
            cpp_assert_signature("TRUE;TRUE;hello" int bool args)
        endfunction()

        ct_add_section(NAME "sig_three_args_second_wrong_type" EXPECTFAIL)
        function(${sig_three_args_second_wrong_type})
            cpp_assert_signature("42;42;hello" int bool args)
        endfunction()
    endfunction()

    ct_add_section(NAME "sig_str_arg")
    function(${sig_str_arg})
        cpp_assert_signature("42" str)
    endfunction()

    ct_add_section(NAME "sig_object")
    function(${sig_object})
        include(cmakepp_lang/object/object)
        cpp_assert_signature("${__CMAKEPP_LANG_OBJECT_SINGLETON__}" obj)
    endfunction()

    ct_add_section(NAME "sig_double_variadic_signature" EXPECTFAIL)
    function(${sig_double_variadic_signature})
        cpp_assert_signature("TRUE;42;FALSE" bool args args)
    endfunction()

endfunction()
