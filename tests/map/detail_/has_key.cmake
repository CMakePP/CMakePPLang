include(cmake_test/cmake_test)

ct_add_test("_cpp_map_has_key")
    include(cmakepp_core/map/map)

    _cpp_map_ctor(my_map)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: must be description")
            _cpp_map_has_key(TRUE "${my_map}" key)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: must be map")
            _cpp_map_has_key(result a_map key)
            ct_assert_fails_as("Assertion: a_map is map")
        ct_end_section()

        ct_add_section("Arg3: must be desc")
            _cpp_map_has_key(result "${my_map}" 1)
            ct_assert_fails_as("Assertion: 1 is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("Is a key")
        _cpp_map_add_key("${my_map}" a_key)
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Is not a key")
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
