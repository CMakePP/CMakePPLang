include(cmake_test/cmake_test)

ct_add_test("cpp_map_has_key")
    include(cmakepp_core/map/map)

    ct_add_section("Map has a single key")
        cpp_map_ctor(a_map foo bar)

        ct_add_section("Has the requested key")
            cpp_map_has_key("${a_map}" result foo)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Does not have the key")
            cpp_map_has_key("${a_map}" result not_a_key)
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Map has multiple keys")
        cpp_map_ctor(a_map foo bar hello world a_number 42)

        ct_add_section("Has the key")
            ct_add_section("foo")
                cpp_map_has_key("${a_map}" result foo)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("hello")
                cpp_map_has_key("${a_map}" result hello)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("a_number")
                cpp_map_has_key("${a_map}" result a_number)
                ct_assert_equal(result TRUE)
            ct_end_section()
        ct_end_section()

        ct_add_section("Does not have the key")
            cpp_map_has_key("${a_map}" result not_a_key)
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()
