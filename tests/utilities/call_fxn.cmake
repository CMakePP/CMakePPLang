include(cmake_test/cmake_test)

ct_add_test("cpp_call_fxn")
    include(cmakepp_core/utilities/call_fxn)

    ct_add_section("Function with no args")
        function(a_fxn)
            set(result "hello world" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn)
        ct_assert_equal(result "hello world")
    ct_end_section()

    ct_add_section("Function with 1 arg")
        function(a_fxn arg0)
            set(result "hello ${arg0}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn world)
        ct_assert_equal(result "hello world")
    ct_end_section()

    ct_add_section("Function with 2 args")
        function(a_fxn arg0 arg1)
            set(result "${arg0}+${arg1}" PARENT_SCOPE)
        endfunction()

        cpp_call_fxn(a_fxn 1 2)
        ct_assert_equal(result "1+2")

        ct_add_section("Can call multiple times")
            cpp_call_fxn(a_fxn 3 4)
            ct_assert_equal(result "3+4")
        ct_end_section()

    ct_end_section()
ct_end_test()
