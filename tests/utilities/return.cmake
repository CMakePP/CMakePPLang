include(cmake_test/cmake_test)

ct_add_test(NAME [[test_return]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/return)

    # Define a dummy function which uses the return function
    function(dummy_fxn)
        set(the_return "hello world")
        cpp_return(the_return)
    endfunction()

    function(return_multiple_values _rmv_rv_1 _rmv_rv_2 _rmv_rv_3 _rmv_prefix)
        set("${_rmv_rv_1}" "${_rmv_prefix}_return_1")
        set("${_rmv_rv_2}" "${_rmv_prefix}_return_2")
        set("${_rmv_rv_3}" "${_rmv_prefix}_return_3")
        cpp_return("${_rmv_rv_1}" "${_rmv_rv_2}" "${_rmv_rv_3}")
    endfunction()

    ct_add_section(NAME [[ensure_the_return_not_defined]])
    function("${CMAKETEST_SECTION}")
        ct_assert_not_defined(the_return)
    endfunction()

    ct_add_section(NAME [[return_equals_hello_world]])
    function("${CMAKETEST_SECTION}")
        dummy_fxn()
        ct_assert_equal(the_return "hello world")
    endfunction()

    ct_add_section(NAME [[multiple_return_values]])
    function("${CMAKETEST_SECTION}")
        set(_prefix "multiple_return_values")
        return_multiple_values(_rv_1 _rv_2 _rv_3 "${_prefix}")

        ct_assert_equal(_rv_1 "${_prefix}_return_1")
        ct_assert_equal(_rv_2 "${_prefix}_return_2")
        ct_assert_equal(_rv_3 "${_prefix}_return_3")
    endfunction()

endfunction()
