include(cmake_test/cmake_test)

ct_add_test(NAME [[variable_equality]])
function("${CMAKETEST_TEST}")

    # Create three strings, two that are equivalent and on that is not
    set(string_a "Hello World")
    set(string_b "Hello World")
    set(string_c "Goodbye World")

    # Check if certain strings are equivalent
    cpp_equal(result_ab "${string_a}" "${string_b}")
    cpp_equal(result_ac "${string_a}" "${string_c}")

    # Print out the results
    message("A equals B? ${result_ab}")
    message("A equals C? ${result_ac}")

    # Output:
    # A equals B? TRUE
    # A equals C? FALSE

    ct_assert_equal(result_ab TRUE)
    ct_assert_equal(result_ac FALSE)

endfunction()
