include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_keys")
function("${test_cpp_map_keys}")
    include(cmakepp_lang/map/map)
    include(cmakepp_lang/utilities/compare_lists)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(cmakepp_lang_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_keys(TRUE result)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            cpp_map_ctor(a_map)
            cpp_map_keys("${a_map}" TRUE)
        endfunction()

        ct_add_section(NAME "takes_two_args" EXPECTFAIL)
        function("${takes_two_args}")
            cpp_map_ctor(a_map)
            cpp_map_keys("${a_map}" result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "no_keys")
    function("${no_keys}")
        cpp_map_ctor(a_map)
        cpp_map_keys("${a_map}" keys)
        set(corr)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME "one_key")
    function("${one_key}")
        cpp_map_ctor(a_map foo bar)
        cpp_map_keys("${a_map}" keys)
        set(corr foo)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME "two_keys")
    function("${two_keys}")
        cpp_map_ctor(a_map foo bar hello world)
        cpp_map_keys("${a_map}" keys)
        set(corr foo hello)
        cpp_compare_lists(result corr keys)
        ct_assert_equal(result TRUE)
    endfunction()
endfunction()
