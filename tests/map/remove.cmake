include(cmake_test/cmake_test)

ct_add_test("cpp_map_set")
    include(cmakepp_core/map/map)
    include(cmakepp_core/serialization/serialization)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(a_map)

        ct_add_section("0th argument must be map")
            cpp_map_remove(TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

    ct_end_section()

    ct_add_section("Removes one key")
        # Create map and remove one key
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_remove("${a_map}" key_2)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    ct_end_section()

    ct_add_section("Removes multiple keys")
        # Create map and remove two keys
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2
                           key_3 value_3 key_4 value_4)
        cpp_map_remove("${a_map}" key_2 key_4)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    ct_end_section()

    ct_add_section("Does nothing for non-existant key")
        # Create map and remove one key
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_remove("${a_map}" key_2 non_existant_key)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    ct_end_section()
ct_end_test()
