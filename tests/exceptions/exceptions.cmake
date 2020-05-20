include(cmake_test/cmake_test)

ct_add_test("cpp_catch")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section("Signature")
    set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("At least one argument")
            cpp_catch()
            ct_assert_fails_as("This function expects at least one argument")
        ct_end_section()

        ct_add_section("Argument is desc")
            cpp_catch(TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()
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

    ct_add_section("Handles multiple exception handlers for different types")
        # Add two exception handlers
        cpp_catch(my_exce_type_1 my_exce_type_2)
        function("${my_exce_type_1}" message)
            message("In my_exception_handler for exception type: my_exce_type_1")
            message("Exception details 1: ${message}")
        endfunction()
        function("${my_exce_type_2}" message)
            message("In my_exception_handler for exception type: my_exce_type_2")
            message("Exception details 2: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type_1 "Here are the details 1")
        cpp_raise(my_exce_type_2 "Here are the details 2")

        # Ensure both handlers were called
        ct_assert_prints("Exception details 1: Here are the details 1")
        ct_assert_prints("Exception details 2: Here are the details 2")
    ct_end_section()

    ct_add_section("Handles multiple exception handlers for the same type")
        # Add first exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In first my_exception_handler for exception type: my_exce_type")
            message("Exception details 1: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type "Here are the details 1")

        # Ensure first handler was called
        ct_assert_prints("Exception details 1: Here are the details 1")

        # Add second exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In second my_exception_handler for exception type: my_exce_type")
            message("Exception details 2: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type "Here are the details 2")

        # Ensure second handler was called
        ct_assert_prints("Exception details 2: Here are the details 2")
    ct_end_section()

    ct_add_section("Handles ALL_EXCEPTIONS handler and no other handlers")
        # Add ALL_EXCEPTIONS handler
        cpp_catch(ALL_EXCEPTIONS)
        function("${ALL_EXCEPTIONS}" exce_type message)
            message("ALL_EXCEPTIONS handler for exception type: ${exce_type}")
            message("Exception details: ${message}")
        endfunction()

        # Raise exception
        cpp_raise(my_exce_type "Here are the details")

        # Ensure ALL_EXCEPTIONS handler was called
        ct_assert_prints("Exception details: Here are the details")
    ct_end_section()

    ct_add_section("Handles ALL_EXCEPTIONS handler and another handler")
        # Add exception handler for ALL_EXCEPTIONS and my_exce_type_1
        cpp_catch(ALL_EXCEPTIONS my_exce_type_1)
        function("${ALL_EXCEPTIONS}" exce_type message)
            message("ALL_EXCEPTIONS handler for exception type: ${exce_type}")
            message("ALL_EXCEPTIONS exception details: ${message}")
        endfunction()
        function("${my_exce_type_1}" message)
            message("In my_exception_handler for exception type: my_exce_type_1")
            message("Exception details 1: ${message}")
        endfunction()

        # Raise exception with no declared handler
        cpp_raise(my_exce_type_2 "Here are the details")

        # Ensure ALL_EXCEPTIONS handler was called
        ct_assert_prints("ALL_EXCEPTIONS exception details: Here are the")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_raise")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_raise(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Fails when no exception handler is found for specified type")
        # Throw exception for exception type with no handler declared
        cpp_raise(my_exce_type)
        ct_assert_fails_as("Uncaught my_exce_type exception:")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_end_try_catch")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("At least one argument")
            cpp_end_try_catch()
            ct_assert_fails_as("This function expects at least one argument")
        ct_end_section()

        ct_add_section("Argument is desc")
            cpp_end_try_catch(TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()
    ct_end_section()

    ct_add_section("Removes one exception handler")
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
        ct_assert_fails_as("Uncaught my_exce_type exception:")
    ct_end_section()

    ct_add_section("Removes last exception handler when multiple are set")
        # Add first exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In first my_exception_handler for exception type: my_exce_type")
            message("Exception details 1: ${message}")
        endfunction()

        # Add second exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In second my_exception_handler for exception type: my_exce_type")
            message("Exception details 2: ${message}")
        endfunction()

        # Remove the exception handler
        cpp_end_try_catch(my_exce_type)

        # Attempt to raise an exception
        cpp_raise(my_exce_type "Here are the details 1")

        # Ensure first handler was called
        ct_assert_prints("Exception details 1: Here are the details 1")
    ct_end_section()

    ct_add_section("Removes ALL_EXCEPTIONS handler")
        # Add ALL_EXCEPTIONS handler
        cpp_catch(ALL_EXCEPTIONS)
        function("${ALL_EXCEPTIONS}" exce_type message)
            message("ALL_EXCEPTIONS handler for exception type: ${exce_type}")
            message("Exception details: ${message}")
        endfunction()

        # Remove ALL_EXCEPTIONS handler
        cpp_end_try_catch(ALL_EXCEPTIONS)

        # Attempt to raise an exception
        cpp_raise(my_exce_type "Here are the details 1")

        # Attempt to raise an exception and ensure it fails
        cpp_raise(my_exce_type)
        ct_assert_fails_as("Uncaught my_exce_type exception:")
    ct_end_section()
ct_end_test()
