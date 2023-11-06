include(cmake_test/cmake_test)

ct_add_test(NAME [[maps]])
function("${CMAKETEST_TEST}")

    set(my_key "my_key")
    set(key_a "key_a")
    set(key_b "key_b")


    # Create an empty map named my_map
    cpp_map(CTOR my_map)

    # Create a map with initial key value pairs
    cpp_map(CTOR my_map key_a "value_a" key_b "value_b")

    # Set the value of my_key to my_value
    cpp_map(SET "${my_map}" my_key "test_value")

    # Access the value at my_key and store it in my_result
    cpp_map(GET "${my_map}" my_result my_key)
    
    ct_assert_equal(my_result "test_value")

    # Append new_value to the value at my_key
    cpp_map(APPEND "${my_map}" my_key "new_value")

    

    cpp_map(GET "${my_map}" my_result my_key)

    ct_assert_equal(my_result "test_value;new_value")

    # Copy my_map to my_map_copy
    cpp_map(COPY "${my_map}" my_map_copy)

    # Check if map_a is equivalent to map_b
    cpp_map(EQUAL "${my_map}" equal_result "${my_map_copy}")

    ct_assert_equal(equal_result TRUE)

    # Check whether the map has the key "my_key"
    cpp_map(HAS_KEY "${my_map}" has_key_result my_key)

    ct_assert_equal(has_key_result TRUE)

    # Put the list of the map's keys in keys_list
    cpp_map(KEYS "${my_map}" keys_list)

    message("${keys_list}")
    ct_assert_equal(keys_list "${key_a};${key_b};${my_key}")

endfunction()
