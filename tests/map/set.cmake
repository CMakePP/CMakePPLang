include(cmake_test/cmake_test)

ct_add_test("cpp_map_set")
    include(cmakepp_core/map/map)

    cpp_map_ctor(a_map)

    ct_add_section("Set to empty string")
        cpp_map_set("${a_map}" foo "")
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result "")
    ct_end_section()

    ct_add_section("Set to a value")
        cpp_map_set("${a_map}" foo bar)
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result bar)
    ct_end_section()

    ct_add_section("Set to a list")
        include(cmakepp_core/utilities/compare_lists)
        set(corr hello world)
        cpp_map_set("${a_map}" foo "${corr}")
        cpp_map_get("${a_map}" value foo)
        cpp_compare_lists(result value corr)
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
