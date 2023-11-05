include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_directory_exists]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/directory_exists)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_directory_exists(TRUE "${CMAKE_CURRENT_SOURCE_DIR}")
        endfunction()

        ct_add_section(NAME [[second_arg_incorrect]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_directory_exists(result TRUE)
        endfunction()

        ct_add_section(NAME [[takes_two_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_directory_exists(result "${CMAKE_CURRENT_SOURCE_DIR}" hello)
        endfunction()
    endfunction()

    ct_add_section(NAME [[directory_exists]])
    function("${CMAKETEST_SECTION}")
        cpp_directory_exists(result "${CMAKE_CURRENT_SOURCE_DIR}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[directory_does_not_exist]])
    function("${CMAKETEST_SECTION}")
        cpp_directory_exists(result "${CMAKE_CURRENT_BINARY_DIR}/not_a_dir")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME [[is_file]])
    function("${CMAKETEST_SECTION}")
        cpp_directory_exists(result "${CMAKE_CURRENT_LIST_FILE}")
        ct_assert_equal(result FALSE)
    endfunction()
endfunction()
