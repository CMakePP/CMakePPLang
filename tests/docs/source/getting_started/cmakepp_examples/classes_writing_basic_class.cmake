# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the default value "red"
    cpp_attr(Automobile color red)

# End class definition
cpp_end_class()

# Create an instance of the class called "my_auto" using the default CTOR
Automobile(CTOR my_auto)

# Access the "color" attribute and save it to the var "my_autos_color"
Automobile(GET "${my_auto}" my_autos_color color)

# Print out the value of the var "my_autos_color"
message("The color of my_auto is: ${my_autos_color}")

# Output: The color of my_auto is: red

# Set a new value for the "color" attribute
Automobile(SET "${my_auto}" color blue)

# Access the "color" attribute again and save it to the var "my_autos_color"
Automobile(GET "${my_auto}" my_autos_color color)

# Print out the value of the var "my_autos_color"
message("The color of my_auto is: ${my_autos_color}")

# Output: The color of my_auto is: blue