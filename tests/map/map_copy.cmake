include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_copy")
function("${test_cpp_map_copy}")
    include(cmakepp_core/map/map)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map(CTOR a_map)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_copy(TRUE result)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            cpp_map_copy("${a_map}" TRUE)
        endfunction()

        ct_add_section(NAME "accepts_two_args" EXPECTFAIL)
        function("${accepts_two_args}")
            cpp_map_copy("${a_map}" result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "empty_map")
    function("${empty_map}")
        cpp_map(CTOR a_map)
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section(NAME "compare_equal")
        function("${compare_equal}")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "diff_instances")
        function("${diff_instances}")
            ct_assert_not_equal(result "${a_copy}")
        endfunction()
    endfunction()

    ct_add_section(NAME "filled_map")
    function("${filled_map}")
        cpp_map(CTOR a_map foo bar hello world)
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section(NAME "compare_equal")
        function("${compare_equal}")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "diff_instances")
        function("${diff_instances}")
            ct_assert_not_equal(result "${a_copy}")
        endfunction()
    endfunction()

    ct_add_section(NAME "nested_map")
    function("${nested_map}")
        cpp_map(CTOR bar hello world)
        cpp_map(CTOR a_map foo "${bar}")
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section(NAME "compare_equal")
        function("${compare_equal}")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "diff_outer_instances")
        function("${diff_outer_instances}")
            ct_assert_not_equal(result "${a_copy}")
        endfunction()

        ct_add_section(NAME "diff_inner_instances")
        function("${diff_inner_instances}")
            cpp_map(GET "${a_map}" bar1 foo)
            cpp_map(GET "${a_copy}" bar2 foo)
            ct_assert_not_equal(bar1 "${bar2}")
        endfunction()
    endfunction()
endfunction()