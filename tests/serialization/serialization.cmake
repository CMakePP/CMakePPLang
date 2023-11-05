include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_serialize]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/serialization/serialization)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_serialize(TRUE hello)
        endfunction()

        ct_add_section(NAME [[takes_two_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_serialize(result hello world)
        endfunction()
    endfunction()

    ct_add_section(NAME [[simple_serialize]])
    function("${CMAKETEST_SECTION}")
        cpp_serialize(result "hello world")
        ct_assert_equal(result [["hello world"]])
    endfunction()

    ct_add_section(NAME [[nested_serialize]])
    function("${CMAKETEST_SECTION}")
        set(a_list 1 2 3)
        cpp_map(CTOR a_map foo bar)
        cpp_map(SET "${a_map}" a_list "${a_list}")

        set(corr [[{ "foo" : "bar", "a_list" : [ "1", "2", "3" ] }]])
        cpp_serialize(result "${a_map}")
        ct_assert_equal(result "${corr}")
    endfunction()
endfunction()
