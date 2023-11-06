include(cmake_test/cmake_test)

cpp_class(ParentClass)

    # Add a virtual member function to be overridden by derived classes
    cpp_member(my_virtual_fxn ParentClass)
    cpp_virtual_member(my_virtual_fxn)

cpp_end_class()

cpp_class(ChildClass ParentClass)

    # Override the virtual fxn
    cpp_member(my_virtual_fxn ChildClass)
    function("${my_virtual_fxn}" self)
        message("I am an instance of ChildClass")
    endfunction()

cpp_end_class()

ct_add_test(NAME [[function_overloading]])
function("${CMAKETEST_TEST}")

    ChildClass(CTOR child_instance)
    ChildClass(my_virtual_fxn "${child_instance}")

    # Output: I am an instance of ChildClass

    ct_assert_prints("I am an instance of ChildClass")

    ParentClass(my_virtual_fxn "${child_instance}")

    # Output: I am an instance of ChildClass

    ct_assert_prints("I am an instance of ChildClass")

endfunction()
