include(cmake_test/cmake_test)

ct_add_test("cpp_map_ctor")
    include(cmakepp_core/map/map)
    include(cmakepp_core/types/type_of)
    include(cmakepp_core/utilities/compare_lists)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Default ctor")
        cpp_map_ctor(a_map)

        ct_add_section("Recognized as a map by CMakePP")
            cpp_type_of(result "${a_map}")
            ct_assert_equal(result map)
        ct_end_section()

        ct_add_section("Has no keys")
            cpp_map(KEYS "${a_map}" keys)
            set(corr)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("One key-value pair")
        cpp_map_ctor(a_map foo bar)

        ct_add_section("Recognized as a map by CMakePP")
            cpp_type_of(result "${a_map}")
            ct_assert_equal(result map)
        ct_end_section()

        ct_add_section("keys == {foo}")
            cpp_map(KEYS "${a_map}" keys)
            set(corr foo)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Foo's value is set correctly")
            cpp_map(GET "${a_map}" result foo)
            ct_assert_equal(result bar)
        ct_end_section()
    ct_end_section()

    ct_add_section("Two key-value pair")
        cpp_map_ctor(a_map foo bar hello world)

        ct_add_section("Recognized as a map by CMakePP")
            cpp_type_of(result "${a_map}")
            ct_assert_equal(result map)
        ct_end_section()

        ct_add_section("keys == {foo, hello}")
            cpp_map(KEYS "${a_map}" keys)
            set(corr foo hello)
            cpp_compare_lists(result corr keys)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Foo's value is set correctly")
            cpp_map(GET "${a_map}" result foo)
            ct_assert_equal(result bar)
        ct_end_section()

        ct_add_section("Hello's value is set correctly")
            cpp_map(GET "${a_map}" result hello)
            ct_assert_equal(result world)
        ct_end_section()
    ct_end_section()
ct_end_test()
