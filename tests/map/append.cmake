include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_append")
function("${test_cpp_map_append}")
    include(cmakepp_core/map/map)
    include(cmakepp_core/utilities/compare_lists)

    cpp_map(CTOR a_map)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_append(TRUE foo bar)
        endfunction()

        ct_add_section(NAME "accepts_three_args" EXPECTFAIL)
        function("${accepts_three_args}")
            cpp_map_append("${a_map}" foo bar hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "append_with_new_key")
    function("${append_with_new_key}")
        macro(setup_append)
            cpp_map(CTOR appendable_map)
            cpp_map(APPEND "${appendable_map}" foo bar)
        endmacro()

        ct_add_section(NAME "keys_equal_foo")
        function("${keys_equal_foo}")
            setup_append()
            cpp_map(KEYS "${appendable_map}" keys)
            set(corr foo)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "get_foo_equals_bar")
        function("${get_foo_equals_bar}")
            setup_append()
            cpp_map(GET "${appendable_map}" result foo)
            ct_assert_equal(result bar)
        endfunction()
    endfunction()

    ct_add_section(NAME "append_under_an_existing_key")
    function("${append_under_an_existing_key}")
        macro(setup_append_existing)
            cpp_map(CTOR appendable_map)
            cpp_map(APPEND "${appendable_map}" foo bar)
            cpp_map(APPEND "${appendable_map}" foo 42)
        endmacro()

        ct_add_section(NAME "keys_equal_foo")
        function("${keys_equal_foo}")
            setup_append_existing()
            cpp_map(KEYS "${appendable_map}" keys)
            set(corr foo)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "get_foo_equals_bar_42")
        function("${get_foo_equals_bar_42}")
            setup_append_existing()
            cpp_map(GET "${appendable_map}" value foo)
            set(corr bar 42)
            cpp_compare_lists(result corr value)
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()
endfunction()
