include(cmake_test/cmake_test)

ct_add_test(NAME "assert")
function("${assert}")

    ct_add_section(NAME "assert_is_int_true")
    function("${assert_is_int_true}")
        # Assert that 3 is an int
        cpp_is_int(is_int 3)
        cpp_assert("${_is_int}" "3 is an integer") # Passes

    endfunction()

    ct_add_section(NAME "assert_greater_than_false" EXPECTFAIL)
    function("${assert_greater_than_false}")
        # Assert that x is greater than 3
        set(x 2)
        cpp_assert("${x};GREATER;3" "x is > 3") # Stops program and prints
    endfunction()

endfunction()
