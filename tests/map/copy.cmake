include(cmake_test/cmake_test)

ct_add_test("cpp_map_copy")
    include(cmakepp_core/map/map)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map(CTOR a_map)

        ct_add_section("0th Argument must be a map")
            cpp_map_copy(TRUE result)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("1st Argument must be a desc")
            cpp_map_copy("${a_map}" TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Accepts Exactly 2 Arguments")
            cpp_map_copy("${a_map}" result hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Empty Map")
        cpp_map(CTOR a_map)
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section("Compare equal")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different instances")
            ct_assert_not_equal(result "${a_copy}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Filled Map")
        cpp_map(CTOR a_map foo bar hello world)
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section("Compare equal")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different instances")
            ct_assert_not_equal(result "${a_copy}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Nested Map")
        cpp_map(CTOR bar hello world)
        cpp_map(CTOR a_map foo "${bar}")
        cpp_map(COPY "${a_map}" a_copy)

        ct_add_section("Compare equal")
            cpp_map(EQUAL "${a_map}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different outer instances")
            ct_assert_not_equal(result "${a_copy}")
        ct_end_section()

        ct_add_section("Different inner instances")
            cpp_map(GET "${a_map}" bar1 foo)
            cpp_map(GET "${a_copy}" bar2 foo)
            ct_assert_not_equal(bar1 "${bar2}")
        ct_end_section()
    ct_end_section()
ct_end_test()
