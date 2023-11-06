include(cmake_test/cmake_test)

ct_add_test(NAME [[handle_all_exceptions]])
function("${CMAKETEST_TEST}")

    # Add general exception handler that catches all exceptions
    cpp_catch(ALL_EXCEPTIONS)
    function("${ALL_EXCEPTIONS}" exce_type message)
        message("ALL_EXCEPTIONS handler for exception type: ${exce_type}")
        message("Exception details: ${message}")
    endfunction()

    # Raise exception for exception type with no declared handler
    cpp_raise(FileNotFound "The file doesn't exist!")

    ct_assert_prints("The file doesn't exist!")

    # Remove the exception handler
    cpp_end_try_catch(ALL_EXCEPTIONS)

endfunction()
