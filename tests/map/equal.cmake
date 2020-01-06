include(cmake_test/cmake_test)

ct_add_test("cpp_map_equal")
    include(cmakepp_core/map/map)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map(CTOR a_map)

        ct_add_section("0th Argument must be map")
            cpp_map_equal(TRUE result "${a_map}")
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("1st Argument must be map")
            cpp_map_equal("${a_map}" TRUE "${a_map}")
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("3rd Argument must be map")
            cpp_map_equal("${a_map}" result TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("Accepts only 3 arguments.")
            cpp_map_equal("${a_map}" result "${a_map}" hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Empty Map == Empty Map")
        cpp_map(CTOR a_map)
        cpp_map(CTOR another_map)
        cpp_map(EQUAL "${a_map}" result "${another_map}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Filled map")
        cpp_map(CTOR a_map foo bar hello world)

        ct_add_section("Different than empty map")
            cpp_map(CTOR another_map)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Different keys")
            cpp_map(CTOR another_map foo1 bar hello1 world)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Different values")
            cpp_map(CTOR another_map foo bar1 hello world1)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Same values, same order")
            cpp_map(CTOR another_map foo bar hello world)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Same values, different order")
            cpp_map(CTOR another_map hello world foo bar)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()
