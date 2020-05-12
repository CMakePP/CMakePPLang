include(cmake_test/cmake_test)
include(cmakepp_core/exceptions/exceptions)

ct_add_test("cpp_catch")
    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_catch(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Handles one exception handler")
        # Add one exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In my_exception_handler for exception type: my_exce_type")
            message("Exception details: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type "Here are the details")

        # Check that handler was called
        ct_assert_prints("Exception details: Here are the details")
    ct_end_section()

    ct_add_section("Handles multiple exception handlers")
        # Add two exception handlers
        cpp_catch(my_exce_type_1)
        function("${my_exce_type_1}" message)
            message("In my_exception_handler for exception type: my_exce_type_1")
            message("Exception details: ${message}")
        endfunction()
        cpp_catch(my_exce_type_2)
        function("${my_exce_type_2}" message)
            message("In my_exception_handler for exception type: my_exce_type_2")
            message("Exception details: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type_1 "Here are the details 1")
        cpp_raise(my_exce_type_2 "Here are the details 2")

        # Ensure both handlers were called
        ct_assert_prints("Exception details: Here are the details 1")
        ct_assert_prints("Exception details: Here are the details 2")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_raise")
    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_raise(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Fails when no exception handler is found for specified type")
        # Throw exception for exception type with no handler declared
        cpp_raise(my_exce_type)
        ct_assert_fails_as("No exception handler for exception type my_exce_type")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_end_try_catch")
    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_end_try_catch(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Removes exception handler")
        # Add one exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In my_exception_handler for exception type: my_exce_type")
            message("Exception details: ${message}")
        endfunction()

        # Remove the exception handler
        cpp_end_try_catch(my_exce_type)

        # Attempt to raise an exception and ensure it fails
        cpp_raise(my_exce_type)
        ct_assert_fails_as("No exception handler for exception type my_exce_type")
    ct_end_section()
ct_end_test()
