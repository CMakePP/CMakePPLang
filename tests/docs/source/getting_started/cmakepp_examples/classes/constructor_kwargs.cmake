include(cmake_test/cmake_test)

# Begin class definition
cpp_class(Automobile)

    # Define an attribute "color" with the value "red"
    cpp_attr(Automobile color red)

    # Define an attribute "num_doors" with a starting value of 4
    cpp_attr(Automobile num_doors 4)

    # Define an attribute "owners" with a blank starting value
    cpp_attr(Automobile owners "")

    # Redefine "describe_self" to have multiple return points
    cpp_member(describe_self Automobile str)
    function("${describe_self}" self return_id)

        # Access the color attribute
        Automobile(GET "${self}" my_color color)

        # Access the num_doors attribute
        Automobile(GET "${self}" my_num_doors num_doors)

        # Access the owners attribute
        Automobile(GET "${self}" my_owners owners)

        # Set the value of the var with the name ${return_id} in the current scope
        set("${return_id}" "I am a ${my_color} automobile with ${my_num_doors} doors, owned by ${my_owners}." PARENT_SCOPE)

    endfunction()

# End class definition
cpp_end_class()

ct_add_test(NAME [[class_constructor_kwargs]])
function("${CMAKETEST_TEST}")

    # Create an instance of the class called "my_auto" using the default CTOR
    Automobile(CTOR my_auto KWARGS color red num_doors 4 owners Alice Bob Chuck)

    # We can still call the original function implementation as well
    Automobile(describe_self "${my_auto}" my_result)

    # Print out the value of "my_result"
    message("${my_result}")

    # Output: I am a red automobile with 4 doors, owned by Alice;Bob;Chuck.

    ct_assert_equal(my_result "I am a red automobile with 4 doors, owned by Alice;Bob;Chuck.")

endfunction()
