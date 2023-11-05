include(cmake_test/cmake_test)

ct_add_test(NAME [[global_variables]])
function("${CMAKETEST_TEST}")

    # Set a global value
    cpp_set_global(key_a "Hello")

    # Get the global value and print it out
    cpp_get_global(result_a key_a)
    message("${result_a}")

    # Output: Hello

    ct_assert_equal(result_a "Hello")

    # Append the global value
    cpp_append_global(key_a " World")

    # Get the global value and print it out again
    cpp_get_global(result_b key_a)
    message("${result_b}")

    # Output: Hello World

    # ASSERTION_FAILED, Details: Assertion: Hello
    # ct_assert_equal(result_b "Hello World")
    # ASSERTION_FAILED, Details: Assertion: == World failed.
    # ct_assert_equal(${result_b} "Hello World")
    # ASSERTION_FAILED, Details: Assertion: == Hello World failed.
    # ct_assert_equal("${result_b}" "Hello World")
    # ASSERTION_FAILED, Details: Assertion: 0 == TRUE failed.
    # string(COMPARE EQUAL "${result_b}" "Hello World" str_cmp)
    # ct_assert_equal(str_cmp TRUE)
    string(COMPARE EQUAL "${result_b}" "Hello World" str_cmp)
    ct_assert_equal(str_cmp 0)

endfunction()
