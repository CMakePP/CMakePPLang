include(cmake_test/cmake_test)

ct_add_test("_cpp_map_has_key")
    include(cmakepp_core/map/map)

    _cpp_map_ctor(my_map)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_map_has_key(result "${my_map}" 1)
        ct_assert_fails_as("1 is desc")
    ct_end_section()

    ct_add_section("Is a key")
        _cpp_map_set("${my_map}" a_key 1)
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Is not a key")
        _cpp_map_has_key(result "${my_map}" a_key)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
