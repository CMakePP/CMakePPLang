include(cmake_test/cmake_test)

# Define the ElectricVehicle class
cpp_class(ElectricVehicle)

    # Attribute for storing the power source of the electric vehicle
    cpp_attr(ElectricVehicle power_source "100 kWh Battery")

    # Function for starting the vehicle
    cpp_member(start ElectricVehicle)
    function("${start}" self)
        message("I have started silently.")
    endfunction()

cpp_end_class()

# Define the Truck class
cpp_class(Truck)

    # Attribute for storing the power source of the truck
    cpp_attr(Truck power_source "20 Gallon Fuel Tank")

    # Function for starting the truck
    cpp_member(start Truck)
    function("${start}" self)
        message("Vroom! I have started my engine.")
    endfunction()

cpp_end_class()

ct_add_test(NAME [[multiple_inheritance_conflicting]])
function("${CMAKETEST_TEST}")

    ct_add_section(NAME [[electric_vehicle_then_truck]])
    function("${CMAKETEST_SECTION}")
        # Define a subclass that inherits from both parent classes
        cpp_class(ElectricTruck ElectricVehicle Truck)

            # This is an empty class that inherits methods and attributes from its parent classes

        cpp_end_class()

        # Create instance of the subclass
        ElectricTruck(CTOR my_inst)

        # Access the power_source attribute
        ElectricTruck(GET "${my_inst}" result power_source)
        message("Power source: ${result}")

        # Output
        # Power source: 100 kWh Battery

        # ct_assert_equal(result "100 kWh Battery")

        ElectricTruck(start "${my_inst}")

        # Output
        # I have started silently.

        ct_assert_prints("I have started silently.")
    endfunction()

    ct_add_section(NAME [[truck_then_electric_vehicle]])
    function("${CMAKETEST_SECTION}")
        # Define a subclass that inherits from both parent classes
        cpp_class(TruckElectric Truck ElectricVehicle)

            # This is an empty class that inherits methods and attributes from its parent classes

        cpp_end_class()

        # Create instance of the subclass
        TruckElectric(CTOR my_inst)

        # Access the power_source attribute
        TruckElectric(GET "${my_inst}" result power_source)
        message("Power source: ${result}")

        # Output
        # Power source: 20 Gallon Fuel Tank

        # ct_assert_equal(result "20 Gallon Fuel Tank")

        TruckElectric(start "${my_inst}")

        # Output
        # Vroom! I have started my engine.

        ct_assert_prints("Vroom! I have started my engine.")
    endfunction()

endfunction()
