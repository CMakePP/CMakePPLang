include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_remove")
function("${test_cpp_map_remove}")
    include(cmakepp_core/map/map)
    include(cmakepp_core/serialization/serialization)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(a_map)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_remove(TRUE)
        endfunction()

    endfunction()

    ct_add_section(NAME "remove_one_key")
    function("${remove_one_key}")
        # Create map and remove one key
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_remove("${a_map}" key_2)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    endfunction()

    ct_add_section(NAME "remove_multi_keys")
    function("${remove_multi_keys}")
        # Create map and remove two keys
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2
                           key_3 value_3 key_4 value_4)
        cpp_map_remove("${a_map}" key_2 key_4)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    endfunction()

    ct_add_section(NAME "no_op_nonexistant_key")
    function("${no_op_nonexistant_key}")
        # Create map and remove one key
        cpp_map_ctor(a_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_remove("${a_map}" key_2 non_existant_key)

        # Ensure key was removed
        set(corr "{ \"key_1\" : \"value_1\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${a_map}")
        ct_assert_equal(res "${corr}")
    endfunction()
endfunction()
