include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_desc_contains_substring]])
function("${CMAKETEST_TEST}")

    # Create a desc
    set(my_desc "Here is a desc")

    # Check if the desc contains certain substrings
    cpp_contains(desc_has_here "Here" "${my_desc}")
    cpp_contains(desc_has_a "a" "${my_desc}")
    cpp_contains(desc_has_foo "foo" "${my_desc}")

    # Print out the results
    message("Desc contains \"Here\"? ${desc_has_here}")
    message("Desc contains \"a\"? ${desc_has_a}")
    message("Desc contains \"foo\"? ${desc_has_foo}")

    # Output:
    # Desc contains "Here"? TRUE
    # Desc contains "a"? TRUE
    # Desc contains "foo"? FALSE

    ct_assert_equal(desc_has_here TRUE)
    ct_assert_equal(desc_has_a TRUE)
    ct_assert_equal(desc_has_foo FALSE)

endfunction()
