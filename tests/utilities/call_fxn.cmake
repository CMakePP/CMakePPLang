include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_call_fxn")
function("${test_cpp_call_fxn}")
    include(cmakepp_core/utilities/call_fxn)

    ct_add_section(NAME "function_no_args")
    function("${function_no_args}")
        function(a_fxn)
            set(result "hello world" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn)
        ct_assert_equal(result "hello world")
    endfunction()

    ct_add_section(NAME "function_one_arg")
    function("${function_one_arg}")
        function(a_fxn arg0)
            set(result "hello ${arg0}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn world)
        ct_assert_equal(result "hello world")
    endfunction()

    ct_add_section(NAME "function_two_args")
    function("${function_two_args}")
        function(a_fxn arg0 arg1)
            set(result "${arg0}+${arg1}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn 1 2)
        ct_assert_equal(result "1+2")

        ct_add_section(NAME "can_call_multi_times")
        function("${can_call_multi_times}")
            cpp_call_fxn(a_fxn 3 4)
            ct_assert_equal(result "3+4")
        endfunction()

    endfunction()
endfunction()
