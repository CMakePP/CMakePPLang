include(cmake_test/cmake_test)

ct_add_test(NAME "nested_try_catch")
function("${nested_try_catch}")

    # Create an empty map named my_map
    cpp_map(CTOR my_map)

    # Create a map with initial key value pairs
    cpp_map(CTOR my_map key_a value_a key_b value_b)

    # Set the value of my_key to my_value
    cpp_map(SET "${my_map}" my_key "test_value")

    # Access the value at my_key and store it in my_result
    cpp_map(GET "${my_map}" my_result my_key)
    message("${my_result}")

    # Output: test_value
    
    ct_assert_equal(my_result "test_value")

    # Append new_value to the value at my_key
    cpp_map(APPEND "${my_map}" my_key "new_value")

    # New value at 'my_key': test_value;new_value

    cpp_map(GET "${my_map}" my_result my_key)

    ct_assert_equal(my_result "test_value;new_value")

    # Copy my_map to my_map_copy
    cpp_map(COPY "${my_map}" my_map_copy)

    cpp_serialize(original_serialized "${my_map}")
    cpp_serialize(copy_serialized "${my_map_copy}")
    ct_assert_equal(original_serialized "${copy_serialized}")

endfunction()
