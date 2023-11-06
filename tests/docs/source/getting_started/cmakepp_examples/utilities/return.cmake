include(cmake_test/cmake_test)

# Define a function with a return value
function(fxn_with_return return_identifier)

    set("${return_identifier}" "test_value")

    cpp_return("${return_identifier}")

endfunction()

# Define a function with a multiple return values
function(fxn_with_multiple_returns return_id_1 return_id_2)

    set("${return_id_1}" "test_value_1")
    set("${return_id_2}" "test_value_2")

    cpp_return("${return_id_1}" "${return_id_2}")

endfunction()

ct_add_test(NAME [[return]])
function("${CMAKETEST_TEST}")

    # Calling the function
    fxn_with_return(return_value)

    message("${return_value}")
    # OUTPUT: test_value

    ct_assert_equal(return_value "test_value")

    fxn_with_multiple_returns(rv_1 rv_2)

    message("${rv_1}")
    # OUTPUT: test_value_1
    message("${rv_2}")
    # OUTPUT: test_value_2

    ct_assert_equal(rv_1 "test_value_1")
    ct_assert_equal(rv_2 "test_value_2")

endfunction()
