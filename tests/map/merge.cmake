include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_map_merge")
function("${test_cpp_map_merge}")
    include(cmakepp_core/map/map)
    include(cmakepp_core/serialization/serialization)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_map_ctor(a_map)

        ct_add_section(NAME "first_arg_map" EXPECTFAIL)
        function("${first_arg_map}")
            cpp_map_merge(TRUE "${a_map}")
        endfunction()

        ct_add_section(NAME "second_arg_map" EXPECTFAIL)
        function("${second_arg_map}")
            cpp_map_merge("${a_map}" TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "merges_empty_maps")
    function("${merges_empty_maps}")
        # Create an empty map and a map with some key-value pairs
        cpp_map_ctor(empty_map)
        cpp_map_ctor(another_map key_1 value_1 key_2 value_2 key_3 value_3)
        cpp_map_merge("${empty_map}" "${another_map}")

        # Ensure all key-value pairs were added
        set(corr "{ \"key_1\" : \"value_1\", \"key_2\" : \"value_2\", \"key_3\" : \"value_3\" }")
        cpp_serialize(res "${empty_map}")
        ct_assert_equal(res "${corr}")
    endfunction()

    ct_add_section(NAME "merge_no_matching_keys")
    function("${merge_no_matching_keys}")
        # Create two maps with non-matching key-value pairs
        cpp_map_ctor(map_1 key_1 value_1)
        cpp_map_ctor(map_2 key_2 value_2)
        cpp_map_merge("${map_1}" "${map_2}")

        # Ensure key-value pairs were added
        set(corr "{ \"key_1\" : \"value_1\", \"key_2\" : \"value_2\" }")
        cpp_serialize(res "${map_1}")
        ct_assert_equal(res "${corr}")
    endfunction()

    ct_add_section(NAME "merge_matching_keys")
    function("${merge_matching_keys}")
        # Create two maps with some matching key-value pairs
        cpp_map_ctor(map_1 key_1 value_1a)
        cpp_map_ctor(map_2 key_1 value_1b key_2 value_2)
        cpp_map_merge("${map_1}" "${map_2}")

        # Ensure key-value pairs were added or merged
        set(corr "{ \"key_1\" : \"value_1b\", \"key_2\" : \"value_2\" }")
        cpp_serialize(res "${map_1}")
        ct_assert_equal(res "${corr}")
    endfunction()
endfunction()
