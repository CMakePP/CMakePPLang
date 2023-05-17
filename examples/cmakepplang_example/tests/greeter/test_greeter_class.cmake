include(cmake_test/cmake_test)

#[[[
# Tests created with CMakeTest are structured similarly to the C++ testing
# package, `Catch2 <https://github.com/catchorg/Catch2>`__. This structures
# the testing framework as a collection of tests, created with
# ``ct_add_test(NAME "<test_name>")`` containing sections with individual
# unit tests added with ``ct_add_section(NAME "<section_name>")``.
# ``EXPECT_FAIL`` can be added to the ``ct_add_section()`` calls if the
# test is expected to fail instead of succeeding.
#]]
ct_add_test(NAME "test_greeter_class")
function("${test_greeter_class}")
    include(greeter/greeter_class)

    #[[[
    # Test that Greeter(hello prints the correct message
    #]]
    ct_add_section(NAME "test_hello")
    function("${test_hello}")

        # Create Greeter instance
        Greeter(CTOR _greeter_obj)

        # Set the 'name' attribute
        Greeter(SET "${_greeter_obj}" name "John Doe")

        # Call Greeter(hello
        Greeter(hello "${_greeter_obj}")

        # Test if the printed message is correct
        ct_assert_prints("Hello, John Doe!")

    endfunction()

endfunction()
