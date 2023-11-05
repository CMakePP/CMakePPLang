include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_copy]])
function("${CMAKETEST_TEST}")

    # Get the type of a value and print the result
    cpp_type_of(result TRUE)
    message("${result}")

    # Output: bool

    ct_assert_equal(result "bool")

endfunction()
