include(cmake_test/cmake_test)

ct_add_test("cpp_map_update")
    include(cmakepp_core/map/map)
    include(cmakepp_core/serialization/serialization)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(a_map)

        ct_add_section("0th argument must be map")
            cpp_map_update(TRUE "${a_map}")
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("1st argument must be map")
            cpp_map_update("${a_map}" TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()
    ct_end_section()

    ct_add_section("Updates empty map")
        # Create an empty map and a map with some key-value pairs
        cpp_map_ctor(empty_map)
        cpp_map_ctor(another_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_update("${empty_map}" "${another_map}")

        # Ensure all key-value pairs were added
        set(corr "{ \"key_1\" : \"value_1\", \"key_2\" : \"value_2\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${empty_map}")
        ct_assert_equal(res "${corr}")
    ct_end_section()

    ct_add_section("Updates map with no matching keys")
        # Create two maps with non-matching key-value pairs
        cpp_map_ctor(map_1 key_1 value_1)
        cpp_map_ctor(map_2 key_2 value_2)
        cpp_map_update("${map_1}" "${map_2}")

        # Ensure key-value pairs were added
        set(corr "{ \"key_1\" : \"value_1\", \"key_2\" : \"value_2\" }")
        cpp_serialize(res "${map_1}")
        ct_assert_equal(res "${corr}")
    ct_end_section()

    ct_add_section("Updates map with matching keys")
        # Create two maps with some matching key-value pairs
        cpp_map_ctor(map_1 key_1 value_1a)
        cpp_map_ctor(map_2 key_1 value_1b key_2 value_2)
        cpp_map_update("${map_1}" "${map_2}")

        # Ensure key-value pairs were added or updated
        set(corr "{ \"key_1\" : \"value_1b\", \"key_2\" : \"value_2\" }")
        cpp_serialize(res "${map_1}")
        ct_assert_equal(res "${corr}")
    ct_end_section()
ct_end_test()
