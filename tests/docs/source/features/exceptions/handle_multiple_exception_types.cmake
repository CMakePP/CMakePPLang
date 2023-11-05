include(cmake_test/cmake_test)

ct_add_test(NAME [[handle_multiple_exception_types]])
function("${CMAKETEST_TEST}")

    # Add two exception handlers
    cpp_catch(FileNotFound ConnectionFailure)
    function("${FileNotFound}" message)
        message("FileNotFound Exception Occured")
        message("Details: ${message}")
    endfunction()
    function("${ConnectionFailure}" message)
        message("ConnectionFailure Exception Occured")
        message("Details: ${message}")
    endfunction()

    # Begin the try block
    cpp_try()
        # Raise a FileNotFound Exception
        cpp_raise(FileNotFound "The file doesn't exist!")
        
        ct_assert_prints("The file doesn't exist!")

        # Raise a ConnectionFailure Exception
        cpp_raise(ConnectionFailure "The file doesn't exist!")
    cpp_end_try_catch(FileNotFound)

    ct_assert_prints("The file doesn't exist!")

endfunction()
