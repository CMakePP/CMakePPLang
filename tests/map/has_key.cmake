include(cmake_test/cmake_test)

ct_add_test("cpp_map_has_key")
    include(cmakepp_core/map/map)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(a_map)

        ct_add_section("0th argument must be a map")
            cpp_map_has_key(TRUE result foo)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("1st argument must be a desc")
            cpp_map_has_key("${a_map}" TRUE foo)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments")
            cpp_map_has_key("${a_map}" result foo hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

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
