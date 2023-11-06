include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_list_contains_value]])
function("${CMAKETEST_TEST}")

    # Create a map containing some initial key value pairs
    cpp_map(CTOR my_map key_a value_a key_b value_b)

    # Check if the map contains a certain keys
    cpp_contains(map_has_key_a key_a "${my_map}")
    cpp_contains(map_has_key_c key_c "${my_map}")

    # Print out the results
    message("Map contains key_a? ${map_has_key_a}")
    message("Map contains key_c? ${map_has_key_c}")

    # Output:
    # Map contains key_a? TRUE
    # Map contains key_c? FALSE

    ct_assert_equal(map_has_key_a TRUE)
    ct_assert_equal(map_has_key_c FALSE)

endfunction()
