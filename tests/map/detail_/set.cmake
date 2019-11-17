include(cmake_test/cmake_test)

ct_add_test("_cpp_map_set")
    include(cmakepp_core/map/detail_/ctor)
    include(cmakepp_core/map/detail_/get)
    include(cmakepp_core/map/detail_/set)

    _cpp_map_ctor(a_map)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: map")
            _cpp_map_set(TRUE a_key a_value)
            ct_assert_fails_as("Assertion: TRUE is map")
        ct_end_section()

        ct_add_section("Arg2: desc")
            _cpp_map_set("${a_map}" TRUE a_value)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("can set a key")
        _cpp_map_set("${a_map}" a_key a_value)
        _cpp_map_get(result "${a_map}" a_key)
        ct_assert_equal(result "a_value")
    ct_end_section()
ct_end_test()
