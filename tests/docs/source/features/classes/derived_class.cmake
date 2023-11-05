include(cmake_test/cmake_test)

cpp_class(ParentClass)

    # Declare some attributes with default values
    cpp_attr(ParentClass color red)
    cpp_attr(ParentClass size 10)

    # Declare a function taking some parameters
    cpp_member(my_fxn ParentClass desc desc)
    function("${my_fxn}" self param_a param_b)
        # Function body
    endfunction()

    # Declare a function taking no parameters
    cpp_member(another_fxn ParentClass)
    function("${another_fxn}" self)
        # Function body
    endfunction()

cpp_end_class()

cpp_class(ChildClass ParentClass)

    # Derived class definition

cpp_end_class()

cpp_class(ChildClass ParentClass)

    # Override the default value "color" attribute
    cpp_attr(ChildClass color blue)

    # Add a new attribute "name" belonging to ChildClass
    cpp_attr(ChildClass name "My Name")

    # Override the "my_fxn" function
    cpp_member(my_fxn ChildClass desc desc)
    function("${my_fxn}" self param_a param_b)
        # Function body with different implementation
    endfunction()

    # Add a new function "new_fxn" belonging to ChildClass
    cpp_member(new_fxn ChildClass)
    function("${new_fxn}" self)
        # Function body
    endfunction()

cpp_end_class()

ct_add_test(NAME [[function_overloading]])
function("${CMAKETEST_TEST}")

    # Create an instance of ChildClass
    ChildClass(CTOR child_instance)

    # Access an inherited attribute through the derived class and parent class
    ChildClass(GET "${child_instance}" my_result size)
    ParentClass(GET "${child_instance}" my_result size)

    # Access an inherited function through the derived class and parent class
    ChildClass(another_fxn "${child_instance}")
    ParentClass(another_fxn "${child_instance}")

    # Access an overridden attribute through the derived class and parent class
    ChildClass(GET "${child_instance}" my_result color)
    ParentClass(GET "${child_instance}" my_result color)

    # Access an overridden function through the derived class and parent class
    ChildClass(my_fxn "${child_instance}" "value_a" "value_b")
    ParentClass(my_fxn "${child_instance}" "value_a" "value_b")

    # Access a newly declared attribute that is present in ChildClass and not
    # ParentClass through the derived class and parent class
    ChildClass(GET "${child_instance}" my_result name)
    ParentClass(GET "${child_instance}" my_result name)

    # Access a newly declared function that is present in ChildClass and not
    # ParentClass through the derived class and parent class
    ChildClass(new_fxn "${child_instance}")
    ParentClass(new_fxn "${child_instance}")

endfunction()
