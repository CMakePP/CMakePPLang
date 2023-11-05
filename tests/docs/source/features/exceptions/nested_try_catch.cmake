include(cmake_test/cmake_test)

ct_add_test(NAME [[nested_try_catch]])
function("${CMAKETEST_TEST}")

    # Declare an exception handler for the outer try-catch block
    cpp_catch(FileNotFound)
    function("${FileNotFound}" message)
        message("Outer FileNotFound Handler")
        message("Details: ${message}")
    endfunction()

    # Begin outer try block
    cpp_try()

        # Declare an exception handler for the inner try-catch block
        cpp_catch(FileNotFound)
        function("${FileNotFound}" message)
            message("Inner FileNotFound Handler")
            message("Details: ${message}")
        endfunction()

        # Begin the inner try block
        cpp_try()
            # Raise an exception (calling the inner handler)
            cpp_raise(FileNotFound "The file doesn't exist!")

            ct_assert_prints("The file doesn't exist!")
        cpp_end_try_catch(FileNotFound)

    cpp_end_try_catch(FileNotFound)

endfunction()
