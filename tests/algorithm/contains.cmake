include(cmake_test/cmake_test)

ct_add_test("cpp_contains")
    include(cmakepp_core/algorithm/contains)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be desc")
            cpp_contains(TRUE an_item a_list)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly three arguments")
            cpp_contains(result an_item a_list hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("list")
        set(a_list 1 2 3)
        ct_add_section("Is in list")
            cpp_contains(result 1 "${a_list}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Is not in list")
            cpp_contains(result 42 "${a_list}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)

        cpp_map(CTOR a_map a_key a_value foo bar)

        ct_add_section("has key")
            cpp_contains(result "foo" "${a_map}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("does not have key")
            cpp_contains(result "bar" "${a_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("string")
        ct_add_section("Is in the string")
            cpp_contains(result "world" "Hello world")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Is not in the string")
            cpp_contains(result "goodbye" "Hello world")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()
