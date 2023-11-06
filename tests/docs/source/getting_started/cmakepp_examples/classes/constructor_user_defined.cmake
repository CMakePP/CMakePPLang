include(cmake_test/cmake_test)

# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define an attribute "km_driven" that takes a starting value of 0
    cpp_attr(Automobile km_driven 0)

    cpp_constructor(CTOR Automobile desc)
    function("${CTOR}" self new_color)
        # Set the color attribute to the value provided
        Automobile(SET "${self}" color "${new_color}")
    endfunction()

    # Define a function "start" that prints a message
    cpp_member(start Automobile)
    function("${start}" self)
        message("Vroom! I have started my engine.")
    endfunction()

    # Overload the "start" function
    cpp_member(start Automobile int)
    function("${start}" self distance_km)
        message("Vroom! I started my engine and I just drove ${distance_km} km.")
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
            set("${return_id}" "I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km.")

            # Return the value and exit the function
            cpp_return("${return_id}")
        endif()

        # This only executes if include_color is false
        # Set the value of the var with the name ${return_id} in the current scope
        set("${return_id}" "I am an automobile and I have driven ${my_km_driven} km.")

        # Return the value and exit the function
        cpp_return("${return_id}")

    endfunction()

# End class definition
cpp_end_class()

ct_add_test(NAME [[constructor_user_defined]])
function("${CMAKETEST_TEST}")

    # Create an instance of the class called "my_auto" using the default CTOR
    Automobile(CTOR my_auto)

    Automobile(GET "${my_auto}" my_color color)

    # 'color' is the default 'red'

    ct_assert_equal(my_color "red")

    # Create an instance of the class called "my_auto_2" using the default
    # user-defined CTOR
    Automobile(CTOR my_auto_2 blue)

    Automobile(GET "${my_auto_2}" my_color color)

    # 'color' is the provided 'blue'

    ct_assert_equal(my_color "blue")

endfunction()
