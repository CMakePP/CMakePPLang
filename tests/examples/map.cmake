include(cmake_test/cmake_test)

ct_add_test("Map class")
    include(cmakepp_core/map/map)

    cpp_map(CTOR a_map foo bar hello world)

    ct_add_section("Value of a_map[foo] == bar")
        cpp_map(GET "${a_map}" result foo)
        ct_assert_equal(result bar)
    ct_end_section()

    ct_add_section("Value of a_map[hello] == world")
        cpp_map(GET "${a_map}" result hello)
        ct_assert_equal(result world)
    ct_end_section()
ct_end_test()
