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

    # Redefine "describe_self" to take in a return identifier
    cpp_member(describe_self Automobile str)
    function("${describe_self}" self return_id)

        # Access the attributes of the class and store them into local vars
        Automobile(GET "${self}" my_color color)
        Automobile(GET "${self}" my_km_driven km_driven)

        # Set the value of the var with the name ${return_id} in the parent scope
        set("${return_id}" "I am an automobile, I am ${my_color}, and I have driven ${my_km_driven} km." PARENT_SCOPE)

    endfunction()

# End class definition
cpp_end_class()

# Begin class definition
cpp_class(Car Automobile)

    # Override the default value of the color attribute
    cpp_attr(Automobile color green)

    # Add a new attribute to the subclass
    cpp_attr(Car num_doors 4)

    # Override the "describe_self" method of the Automobile class
    cpp_member(describe_self Car str)
    function("${describe_self}" self result_id)
        # Get inherited and new attributes
        Car(GET "${self}" my_color color)
        Car(GET "${self}" my_km_driven km_driven)
        Car(GET "${self}" my_num_doors num_doors)

        # Set the return value
        set("${result_id}" "I am a car with ${my_num_doors} doors, I am ${my_color}, and I have driven ${my_km_driven} km." PARENT_SCOPE)
    endfunction()

# End class definition
cpp_end_class()

ct_add_test(NAME [[derived_class]])
function("${CMAKETEST_TEST}")

    ct_add_section(NAME [[access_from_derived_class]])
    function("${CMAKETEST_SECTION}")
        # Create an instance of the derived class "Car"
        Car(CTOR my_car)

        # Access the overridden method "describe_self" through the derived class
        Car(describe_self "${my_car}" car_result)
        message("${car_result}")

        # Output: I am a car with 4 doors, I am green, and I have driven 0 km.

        ct_assert_equal(car_result "I am a car with 4 doors, I am green, and I have driven 0 km.")

        # Access the inherited method "start" through the derived class
        Car(start "${my_car}")

        # Output: Vroom! I have started my engine.

        ct_assert_prints("Vroom! I have started my engine.")
        
    endfunction()

    ct_add_section(NAME [[access_from_base_class]])
    function("${CMAKETEST_SECTION}")
        # Create an instance of the derived class "Car"
        Car(CTOR my_car)
        
        # Access the overridden method "describe_self" through the base class
        Automobile(describe_self "${my_car}" auto_result)
        message("${auto_result}")

        # Output: I am a car with 4 doors, I am red, and I have driven 0 km.

        ct_assert_equal(auto_result "I am a car with 4 doors, I am green, and I have driven 0 km.")

        # Access the inherited method "start" through the base class
        Automobile(start "${my_car}")

        # Output: Vroom! I have started my engine.

        ct_assert_prints("Vroom! I have started my engine.")

    endfunction()
endfunction()
