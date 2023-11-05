include(cmake_test/cmake_test)

# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define a function "start" that prints a message
    cpp_member(start Automobile)
    function("${start}" self)
        message("Vroom! I have started my engine.")
    endfunction()

# End class definition
cpp_end_class()

ct_add_test(NAME [[function_referencing_attributes]])
function("${CMAKETEST_TEST}")

    # Create an instance of the class called "my_auto" using the default CTOR
    Automobile(CTOR my_auto)

    # Call the function using our Automobile instance
    Automobile(start "${my_auto}")

    # Output: Vroom! I have started my engine.

    ct_assert_prints("Vroom! I have started my engine.")

endfunction()
