include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_append_global]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/global)

    ct_add_section(NAME [[test_signature]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_append_global(a_key true 42)
    endfunction()

    ct_add_section(NAME [[nonexistent_var]])
    function("${CMAKETEST_SECTION}")
        cpp_append_global(a_key 42)
        cpp_get_global(result a_key)
        ct_assert_equal(result 42)
    endfunction()

    ct_add_section(NAME [[existing_var]])
    function("${CMAKETEST_SECTION}")
        include(cmakepp_lang/utilities/compare_lists)
        cpp_append_global(a_key_2 foo)
        cpp_append_global(a_key_2 bar)
        cpp_get_global(value a_key_2)
        set(corr foo bar)
        cpp_compare_lists(result corr value)
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[is_case_insens]])
    function("${CMAKETEST_SECTION}")
        cpp_append_global(a_key_3 foo)
        cpp_get_global(result A_KEY_3)
        ct_assert_equal(result foo)
    endfunction()
endfunction()

ct_add_test(NAME [[test_cpp_set_global]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/global)

    ct_add_section(NAME [[test_signature]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_set_global(a_key true 42)
    endfunction()

    ct_add_section(NAME [[nonexistent_var]])
    function("${CMAKETEST_SECTION}")
        cpp_set_global(a_key_4 42)
        cpp_get_global(result a_key_4)
        ct_assert_equal(result 42)
    endfunction()

    ct_add_section(NAME [[overwrites_existing_var]])
    function("${CMAKETEST_SECTION}")
        cpp_set_global(a_key_5 foo)
        cpp_set_global(a_key_5 bar)
        cpp_get_global(result a_key_5)
        ct_assert_equal(result bar)
    endfunction()

    ct_add_section(NAME [[is_case_insens]])
    function("${CMAKETEST_SECTION}")
        cpp_set_global(a_key_6 foo)
        cpp_get_global(result A_KEY_6)
        ct_assert_equal(result foo)
    endfunction()
endfunction()

ct_add_test(NAME [[test_cpp_get_global]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/global)

    ct_add_section(NAME [[test_signature]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_get_global(result a_key 42)
    endfunction()

    ct_add_section(NAME [[get_nonexistent_var]])
    function("${CMAKETEST_SECTION}")
        cpp_get_global(result a_key_7)
        ct_assert_equal(result "")
    endfunction()
endfunction()
