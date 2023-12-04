include(cmake_test/cmake_test)

# The ElectricVehicle class
cpp_class(ElectricVehicle)

    # Attribute for storing battery percentage
    cpp_attr(ElectricVehicle battery_percentage 100)

    # Function for starting the vehicle
    cpp_member(drive ElectricVehicle)
    function("${drive}" self)
        message("I am driving.")
    endfunction()

cpp_end_class()

# The Truck class
cpp_class(Truck)

    # Attribute for storing towing capacity
    cpp_attr(Truck towing_cap_lbs 3500)

    # Function for driving the truck
    cpp_member(tow Truck)
    function("${tow}" self)
        message("I am towing.")
    endfunction()

cpp_end_class()

# Define a subclass that inherits from both parent classes
cpp_class(ElectricTruck ElectricVehicle Truck)

    # This is an empty class that inherits methods and attributes from its parent classes

cpp_end_class()

ct_add_test(NAME [[multiple_inheritance_basics]])
function("${CMAKETEST_TEST}")

    ct_add_section(NAME [[parent_attribute_access]])
    function("${CMAKETEST_SECTION}")
        # Create instance of the subclass
        ElectricTruck(CTOR my_inst)

        # Access the attributes of each parent class through the ElectricTruck class
        ElectricTruck(GET "${my_inst}" result1 battery_percentage)
        message("Battery percentage: ${result1}%")
        ElectricTruck(GET "${my_inst}" result2 towing_cap_lbs)
        message("Towing capactiy: ${result2} lbs")

        # Output:
        # Battery percentage: 100%
        # Towing capactiy: 3500 lbs

        ct_assert_equal(result1 "100")
        ct_assert_equal(result2 "3500")
    endfunction()

    ct_add_section(NAME [[parent_method_access]])
    function("${CMAKETEST_SECTION}")
        # Create instance of the subclass
        ElectricTruck(CTOR my_inst)

        # Access the functions of each parent class through the ElectricTruck class
        ElectricTruck(drive "${my_inst}")
        ct_assert_prints("I am driving.")
        ElectricTruck(tow "${my_inst}")
        ct_assert_prints("I am towing.")

        # Output:
        # I am driving.
        # I am towing.

    endfunction()

endfunction()
