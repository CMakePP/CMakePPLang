include(cmake_test/cmake_test)

# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define an attribute "km_driven" that takes a starting value of 0
    cpp_attr(Automobile km_driven 0)

    # Define a function "start" that prints a message
    cpp_member(start Automobile)
    function("${start}" self)
        message("Vroom! I have started my engine.")
    endfunction()

    # Define a function "drive" that takes an int and a str and prints a message
    cpp_member(drive Automobile int str)
    function("${drive}" self distance_km destination)
        message("I just drove ${distance_km} km to ${destination}!")
    endfunction()

    # Redefine "describe_self" to have multiple return points
    cpp_member(describe_self Automobile str bool)
    function("${describe_self}" self return_id include_color)

        # Access the km_driven attribute
        Automobile(GET "${self}" my_km_driven km_driven)

        if(include_color)
            # Access the color attribute
            Automobile(GET "${self}" my_color color)

            # Set the value of the var with the name ${return_id} in the current scope
            set("${return_id}" "I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km." PARENT_SCOPE)
            return()
        endif()

        # This only executes if include_color is false
        # Set the value of the var with the name ${return_id} in the current scope
        set("${return_id}" "I am an automobile and I have driven ${my_km_driven} km." PARENT_SCOPE)
        return()

    endfunction()

# End class definition
cpp_end_class()

ct_add_test(NAME [[function_multiple_return_points]])
function("${CMAKETEST_TEST}")

    # Create an instance of the class called "my_auto" using the default CTOR
    Automobile(CTOR my_auto)

    # Call the function and specify that color should be included
    Automobile(describe_self "${my_auto}" my_result TRUE)
    message("${my_result}")

    # Output: I am an automobile, I am red, and I have driven 0 km.

    ct_assert_equal(my_result "I am an automobile, I am red, and I have driven 0 km.")

    # Call the function and specify that color should NOT be included
    Automobile(describe_self "${my_auto}" my_result FALSE)
    message("${my_result}")

    # Output: I am an automobile and I have driven 0 km.

    ct_assert_equal(my_result "I am an automobile and I have driven 0 km.")

endfunction()