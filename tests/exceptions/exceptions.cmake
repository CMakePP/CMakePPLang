include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_catch")
function("${test_cpp_catch}")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)
        ct_add_section(NAME "at_least_one_arg" EXPECTFAIL)
        function("${at_least_one_arg}")
            cpp_catch()
        endfunction()

        ct_add_section(NAME "arg_is_desc" EXPECTFAIL)
        function("${arg_is_desc}")
            cpp_catch(TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "one_handler")
    function("${one_handler}")
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
    endfunction()

    ct_add_section(NAME "multi_handlers_diff_types")
    function("${multi_handlers_diff_types}")
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

        #Ensure first prints
        ct_assert_prints("Exception details 1: Here are the details 1")

        cpp_raise(my_exce_type_2 "Here are the details 2")

        # Ensure both handlers were called

        ct_assert_prints("Exception details 2: Here are the details 2")
    endfunction()

    ct_add_section(NAME "multi_handlers_same_type")
    function("${multi_handlers_same_type}")
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
    endfunction()

    ct_add_section(NAME "all_exceptions_handler")
    function("${all_exceptions_handler}")
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
    endfunction()

    ct_add_section(NAME "all_exceptions_and_other_type")
    function("${all_exceptions_and_other_type}")
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
    endfunction()
endfunction()

ct_add_test(NAME "test_cpp_raise")
function("${test_cpp_raise}")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        cpp_raise(TRUE)
    endfunction()

    ct_add_section(NAME "no_handler" EXPECTFAIL)
    function("${no_handler}")
        # Throw exception for exception type with no handler declared
        cpp_raise(my_exce_type)
    endfunction()
endfunction()

ct_add_test(NAME "test_cpp_end_try_catch")
function("${test_cpp_end_try_catch}")
    include(cmakepp_core/exceptions/exceptions)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)
        ct_add_section(NAME "at_least_one_arg" EXPECTFAIL)
        function("${at_least_one_arg}")
            cpp_end_try_catch()
        endfunction()

        ct_add_section(NAME "arg_is_desc" EXPECTFAIL)
        function("${arg_is_desc}")
            cpp_end_try_catch(TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "removes_one_exception_handler" EXPECTFAIL)
    function("${removes_one_exception_handler}")
        # Add one exception handler
        cpp_catch(my_exce_type)
        function("${my_exce_type}" message)
            message("In my_exception_handler for exception type: my_exce_type")
            message("Exception details: ${message}")
        endfunction()

        # Remove the exception handler
        cpp_end_try_catch(my_exce_type)

        # Attempt to raise an exception and ensure it fails
        cpp_raise(my_exce_type "test should fail")
    endfunction()

    ct_add_section(NAME "remove_last_when_multi")
    function("${remove_last_when_multi}")
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
    endfunction()

    ct_add_section(NAME "remove_all_exceptions_handler" EXPECTFAIL)
    function("${remove_all_exceptions_handler}")
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
    endfunction()
endfunction()
