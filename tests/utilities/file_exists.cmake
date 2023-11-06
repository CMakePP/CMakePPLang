include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_file_exists]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/file_exists)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_file_exists(TRUE "${CMAKE_CURRENT_LIST_FILE}")
        endfunction()

        ct_add_section(NAME [[second_arg_path]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_file_exists(result TRUE)
        endfunction()

        ct_add_section(NAME [[takes_two_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_file_exists(result "${CMAKE_CURRENT_LIST_FILE}" hello)
        endfunction()
    endfunction()

    ct_add_section(NAME [[file_exists]])
    function("${CMAKETEST_SECTION}")
        cpp_file_exists(result "${CMAKE_CURRENT_LIST_FILE}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[file_does_not_exist]])
    function("${CMAKETEST_SECTION}")
        cpp_file_exists(result "${CMAKE_CURRENT_BINARY_DIR}/not_a_file.txt")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME [[is_dir]])
    function("${CMAKETEST_SECTION}")
        cpp_file_exists(result "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(result FALSE)
    endfunction()
endfunction()
