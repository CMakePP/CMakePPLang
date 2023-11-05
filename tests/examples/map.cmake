include(cmake_test/cmake_test)

ct_add_test(NAME [[map_class]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/map/map)

    cpp_map(CTOR a_map foo bar hello world)

    ct_add_section(NAME [[get_foo_equal_bar]])
    function("${CMAKETEST_SECTION}")
        cpp_map(GET "${a_map}" result foo)
        ct_assert_equal(result bar)
    endfunction()

    ct_add_section(NAME [[get_hello_equal_world]])
    function("${CMAKETEST_SECTION}")
        cpp_map(GET "${a_map}" result hello)
        ct_assert_equal(result world)
    endfunction()
endfunction()
