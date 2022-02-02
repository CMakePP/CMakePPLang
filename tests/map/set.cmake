include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_set")
function("${test_cpp_map_set}")
    include(cmakepp_core/map/map)

    cpp_map_ctor(a_map)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_set(TRUE key value)
        endfunction()

    endfunction()

    ct_add_section(NAME "set_empty_string")
    function("${set_empty_string}")
        cpp_map_set("${a_map}" foo "")
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result "")
    endfunction()

    ct_add_section(NAME "set_val")
    function("${set_val}")
        cpp_map_set("${a_map}" foo bar)
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result bar)
    endfunction()

    ct_add_section(NAME "set_list")
    function("${set_list}")
        include(cmakepp_core/utilities/compare_lists)
        set(corr hello world)
        cpp_map_set("${a_map}" foo "${corr}")
        cpp_map_get("${a_map}" value foo)
        cpp_compare_lists(result value corr)
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME "override_existing")
    function("${override_existing}")
        cpp_map_set("${a_map}" foo bar)
        cpp_map_set("${a_map}" foo 42)
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result 42)
    endfunction()
endfunction()
