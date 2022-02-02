include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_unique_id")
function("${test_cpp_unique_id}")
    include(cmakepp_core/utilities/unique_id)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_desc" EXPECTFAIL)
        function("${first_arg_desc}")
            cpp_unique_id(TRUE)
        endfunction()

        ct_add_section(NAME "takes_one_arg" EXPECTFAIL)
        function("${takes_one_arg}")
            cpp_unique_id(result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "generated_ids_unique")
    function("${generated_ids_unique}")
        cpp_unique_id(result0)
        cpp_unique_id(result1)
        cpp_unique_id(result2)
        ct_assert_not_equal(result0 "${result1}")
        ct_assert_not_equal(result0 "${result2}")
        ct_assert_not_equal(result1 "${result2}")
    endfunction()
endfunction()
