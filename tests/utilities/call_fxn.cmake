include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_call_fxn]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/call_fxn)

    ct_add_section(NAME [[function_no_args]])
    function("${CMAKETEST_SECTION}")
        function(a_fxn)
            set(result "hello world" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn)
        ct_assert_equal(result "hello world")
    endfunction()

    ct_add_section(NAME [[function_one_arg]])
    function("${CMAKETEST_SECTION}")
        function(a_fxn arg0)
            set(result "hello ${arg0}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn world)
        ct_assert_equal(result "hello world")
    endfunction()

    ct_add_section(NAME [[function_two_args]])
    function("${CMAKETEST_SECTION}")
        function(a_fxn arg0 arg1)
            set(result "${arg0}+${arg1}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn 1 2)
        ct_assert_equal(result "1+2")

        ct_add_section(NAME [[can_call_multi_times]])
        function("${CMAKETEST_SECTION}")
            cpp_call_fxn(a_fxn 3 4)
            ct_assert_equal(result "3+4")
        endfunction()

    endfunction()

    # This test will crash if it isn't working properly
    ct_add_section(NAME [[unmatched_escaped_quotes]])
    function("${CMAKETEST_SECTION}")
        cpp_catch(TEST_EXCEPTION)

        function("${TEST_EXCEPTION}" message)
            message("This does not execute")
        endfunction()

        cpp_raise(TEST_EXCEPTION "\"test")

        ct_assert_prints("This does not execute")
    endfunction()
endfunction()


