# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define an attribute "km_driven" that takes a starting value of 0
    cpp_attr(Automobile km_driven 0)

    # Define a function "describe_self" that references attributes of the class
    cpp_member(describe_self Automobile)
    function("${describe_self}" self)

        # Access the attributes of the class and store them into the local vars
        # _ds_color and _ds_km_driven
        Automobile(GET "${self}" _ds color km_driven)

        # Print out a message
        message("I am an automobile, I am ${_ds_color}, and I have driven ${_ds_km_driven} km.")

    endfunction()

# End class definition
cpp_end_class()

# Create an instance of the class called "my_auto" using the default CTOR
Automobile(CTOR my_auto)

# Call the function using the instance "my_auto"
Automobile(describe_self "${my_auto}")

# Output: I am an automobile, I am red, and I have driven 0 km.