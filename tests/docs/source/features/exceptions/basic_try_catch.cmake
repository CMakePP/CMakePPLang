include(cmake_test/cmake_test)

ct_add_test(NAME [[basic_try_catch]])
function("${CMAKETEST_TEST}")

    # Add an exception handler
    cpp_catch(FileNotFound)
    function("${FileNotFound}" message)
        message("FileNotFound Exception Occured")
        message("Details: ${message}")
    endfunction()

    # Begin the try block
    cpp_try()
        # If an error occurs, raise an exception and pass along details
        cpp_raise(FileNotFound "The file doesn't exist!")
    cpp_end_try_catch(FileNotFound)

    ct_assert_prints("The file doesn't exist!")

endfunction()
