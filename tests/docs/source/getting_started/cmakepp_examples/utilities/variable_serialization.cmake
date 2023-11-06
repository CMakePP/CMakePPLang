include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_serialization]])
function("${CMAKETEST_TEST}")

    # Create a map containing a desc
    cpp_map(CTOR my_map desc_key "Hello World")

    # Create a list and it to the map
    set(my_list 1 2 3)
    cpp_map(SET "${my_map}" list_key "${my_list}")

    # Serialize the map and print out the result
    cpp_serialize(serialized "${my_map}")
    message("${serialized}")

    # Output:
    # { "desc_key" : "Hello World", "list_key" : [ "1", "2", "3" ] }

    ct_assert_equal(
        serialized 
        "{ \"desc_key\" : \"Hello World\", \"list_key\" : [ \"1\", \"2\", \"3\" ] }"
    )

endfunction()
