include(cmake_test/cmake_test)

ct_add_test("_cpp_map_are_equal")
    include(cmakepp_core/map/map)
    cpp_map(CTOR lhs)
    cpp_map(SET "${lhs}" a_key 42)
    cpp_map(SET "${lhs}" another_key "Hello World")

    ct_add_section("LHS == Empty map")
        cpp_map(CTOR rhs)
        ct_add_section("RHS == Empty map")
            cpp_map(CTOR lhs2)
            _cpp_map_are_equal(result "${lhs2}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("RHS == non-empty")
            # Uses the fact that lhs is not-empty, whereas we made an empty rhs
            _cpp_map_are_equal(result "${rhs}" "${lhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("LHS == filled map")
        ct_add_section("Same map instance")
            _cpp_map_are_equal(result "${lhs}" "${lhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different instances, but same")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" another_key "Hello World")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different values, but same keys")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" another_key "foo bar")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Same values, but different keys")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" foo_bar "hello world")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("CMakePP Objects as keys")
        include(cmakepp_core/array/array)

        cpp_array(CTOR lhs_key1)
        cpp_array(CTOR lhs_key2 1 2 3)
        cpp_array(CTOR lhs_key3 foo bar)

        cpp_map(CTOR lhs "${lhs_key1}" "hello world"
                         "${lhs_key2}" "${lhs_key3}")

        ct_add_section("RHS is same instance")
            _cpp_map_are_equal(result "${lhs}" "${lhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("RHS uses same key instances")
            cpp_map(CTOR rhs "${lhs_key1}" "hello world"
                             "${lhs_key2}" "${lhs_key3}")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("RHS uses different key instances")
            set(CMAKEPP_CORE_DEBUG_MODE ON)
            cpp_array(CTOR rhs_key1)
            cpp_array(CTOR rhs_key2 1 2 3)
            cpp_array(CTOR rhs_key3 foo bar)
            cpp_map(CTOR rhs "${rhs_key1}" "hello world"
                             "${rhs_key2}" "${rhs_key3}")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("RHS is different")
            cpp_map(CTOR rhs "${lhs_key2}" 42)
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()
