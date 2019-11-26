include(cmake_test/cmake_test)

ct_add_test("_cpp_assert_has_key")
    include(cmakepp_core/map/map)

    cpp_map(CTOR my_map)

    ct_add_section("CMakePP is in debug mode")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("has the key")
            cpp_map(SET "${my_map}" "foo" "bar")
            _cpp_map_assert_has_key("${my_map}" "foo")
        ct_end_section()

        ct_add_section("does not have the key")
            _cpp_map_assert_has_key("${my_map}" "foo")
            ct_assert_fails_as("Assertion: map contains key 'foo'")
        ct_end_section()
    ct_end_section()
ct_end_test()
