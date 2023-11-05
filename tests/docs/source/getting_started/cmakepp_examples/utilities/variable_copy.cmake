include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_copy]])
function("${CMAKETEST_TEST}")

    # Create a list
    set(my_list 1 2 3)

    # Create a map containing a desc and a list
    cpp_map(CTOR my_map desc_key "desc" list_key "${my_list}")

    # Create a copy of the map
    cpp_copy(map_copy "${my_map}")

    # Serialize the copy and print out the result
    cpp_serialize(serialized "${map_copy}")
    message("${serialized}")

    # Output:
    # { "desc_key" : "Hello World", "list_key" : [ "1", "2", "3" ] }

    cpp_serialize(original_serialized "${my_map}")
    message("${original_serialized}")

    ct_assert_equal(serialized "${original_serialized}")
endfunction()
