include(cmake_test/cmake_test)

ct_add_test("cpp_map_append")
    include(cmakepp_core/map/map)
    include(cmakepp_core/utilities/compare_lists)

    cpp_map(CTOR a_map)

    ct_add_section("Append under a new key")
        cpp_map(APPEND "${a_map}" foo bar)

        ct_add_section("Keys == {foo}")
            cpp_map(KEYS "${a_map}" keys)
            set(corr foo)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("a_map[foo] == bar")
            cpp_map(GET "${a_map}" result foo)
            ct_assert_equal(result bar)
        ct_end_section()
    ct_end_section()

    ct_add_section("Append under an existing key")
        cpp_map(APPEND "${a_map}" foo bar)
        cpp_map(APPEND "${a_map}" foo 42)

        ct_add_section("Keys == {foo}")
            cpp_map(KEYS "${a_map}" keys)
            set(corr foo)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("a_map[foo] == [bar, 42]")
            cpp_map(GET "${a_map}" value foo)
            set(corr bar 42)
            cpp_compare_lists(result corr value)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()
