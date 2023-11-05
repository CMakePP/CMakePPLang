include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_list_contains_value]])
function("${CMAKETEST_TEST}")

    # Create list containing some values
    set(my_list 1 2 3 "hello" "world")

    # Check if the list contains certain values
    cpp_contains(list_has_two 2 "${my_list}")
    cpp_contains(list_has_hello "hello" "${my_list}")
    cpp_contains(list_has_foo "foo" "${my_list}")

    # Print out the results
    message("List contains 2? ${list_has_two}")
    message("List contains \"hello\"? ${list_has_hello}")
    message("List contains \"foo\"? ${list_has_foo}")

    # Output:
    # List contains 2? TRUE
    # List contains "hello"? TRUE
    # List contains "foo"? FALSE

    ct_assert_equal(list_has_two TRUE)
    ct_assert_equal(list_has_hello TRUE)
    ct_assert_equal(list_has_foo FALSE)

endfunction()
