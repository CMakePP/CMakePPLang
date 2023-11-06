include(cmake_test/cmake_test)

ct_add_test(NAME [[file_exists]])
function("${CMAKETEST_TEST}")

    # Check if some files exist
    cpp_file_exists(result_1 "/home/joe/file_that_exists.txt")
    cpp_file_exists(result_2 "/home/joe/file_that_does_not_exists.txt")

    # Call the function and pass in directory
    cpp_file_exists(result_3 "/home/joe/Desktop")

    message("${result_1}")
    message("${result_2}")
    message("${result_3}")

    # Output:
    # TRUE
    # FALSE
    # FALSE

    # We can't actually test that something exists
    # ct_assert_equal(result_1 TRUE)

    # But we can test that one does not
    ct_assert_equal(result_2 FALSE)
    ct_assert_equal(result_3 FALSE)

endfunction()
