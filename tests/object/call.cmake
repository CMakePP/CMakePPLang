include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_object_call_guts]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_singleton(singleton)

    ct_add_section(NAME [[return_symbol_valid_call]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_call_guts("${singleton}" result "equal" huh "${singleton}")
        ct_assert_equal(result _cpp_obj_equal_obj_desc_obj_)
    endfunction()

    ct_add_section(NAME [[symbol_not_exist_err]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        _cpp_object_call_guts(
            "${singleton}" result "equal"
        )
    endfunction()
endfunction()

ct_add_test(NAME [[test_cpp_object_call]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_singleton(singleton)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_obj]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_call(TRUE equal)
        endfunction()

        ct_add_section(NAME [[second_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_call("${singleton}" TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME [[call_member_function]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_call("${singleton}" "equal" result "${singleton}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[member_function_names_case_insensitive]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_call("${singleton}" "EqUaL" result "${singleton}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[no_overload_err]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        _cpp_object_call("${singleton}" equal)
    endfunction()
endfunction()
