include(cmake_test/cmake_test)

ct_add_test("_cpp_map_get")
    include(cmakepp_core/map/detail_/ctor)
    include(cmakepp_core/map/detail_/get)
    include(cmakepp_core/map/detail_/set)

    _cpp_map_ctor(a_map)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: desc")
            _cpp_map_get(TRUE "${a_map}" a_key)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: map")
            _cpp_map_get(result TRUE a_key)
            ct_assert_fails_as("Assertion: TRUE is map")
        ct_end_section()

        ct_add_section("Arg3: desc")
            _cpp_map_get(result "${a_map}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("can get a value")
        _cpp_map_set("${a_map}" a_key a_value)
        _cpp_map_get(result "${a_map}" a_key)
        ct_assert_equal(result "a_value")
    ct_end_section()

    ct_add_section("fails if key does not exist")
        _cpp_map_get(result "${a_map}" not_a_key)
        ct_assert_fails_as("Map does not contain key: not_a_key")
    ct_end_section()
ct_end_test()
