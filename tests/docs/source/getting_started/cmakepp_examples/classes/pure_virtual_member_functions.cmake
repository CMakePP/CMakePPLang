# Define the Vehicle class
cpp_class(Vehicle)

    # Add a virtual member function to be overridden by derived classes
    cpp_member(describe_self Vehicle)
    cpp_virtual_member(describe_self)

cpp_end_class()

# Define the Truck class
cpp_class(Truck Vehicle)

    cpp_member(describe_self Truck)
    function("${describe_self}" self)
        message("I am a truck!")
    endfunction()

cpp_end_class()

# Create an instance of the Truck class and call describe_self
Truck(CTOR my_inst)
Truck(describe_self "${my_inst}")

# Output: I am a truck!
