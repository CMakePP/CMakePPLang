include(cmake_test/cmake_test)

ct_add_test("_cpp_map_get")
    include(cmakepp_core/map/detail_/ctor)
    include(cmakepp_core/map/detail_/get)
    include(cmakepp_core/map/detail_/set)

    _cpp_map_ctor(a_map)

    ct_add_section("can get a value")
        _cpp_map_set("${a_map}" a_key a_value)
        _cpp_map_get(result "${a_map}" a_key)
        ct_assert_equal(result "a_value")
    ct_end_section()

    ct_add_section("fails if key does not exist")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_map_get(result "${a_map}" not_a_key)
        ct_assert_fails_as("Assertion: map contains key 'not_a_key'")
    ct_end_section()
ct_end_test()
