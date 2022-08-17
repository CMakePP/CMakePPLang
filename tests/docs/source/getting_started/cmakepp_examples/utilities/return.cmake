include(cmake_test/cmake_test)

# Define a function with a return value
function(fxn_with_return return_identifier)

    set("${return_identifier}" "test_value")

    cpp_return("${return_identifier}")

endfunction()

ct_add_test(NAME "return")
function("${return}")

    # Calling the function
    fxn_with_return(return_value)

    message("${return_value}")
    # OUTPUT: test_value

    ct_assert_equal(return_value "test_value")

endfunction()
