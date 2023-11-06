include(cmake_test/cmake_test)

ct_add_test(NAME [[create_unique_id]])
function("${CMAKETEST_TEST}")

    # Create a unique ID and print it out
    cpp_unique_id(new_uid)
    message("${new_uid}")

    # Outputs something like: 9ii6l_1581033874

    ct_assert_prints("")

endfunction()
