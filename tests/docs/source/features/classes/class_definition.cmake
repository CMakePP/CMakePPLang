include(cmake_test/cmake_test)

ct_add_test(NAME [[class_definition]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/cmakepp_lang)

    ct_add_section(NAME [[no_end_class_name]])
    function("${CMAKETEST_SECTION}")

        # Begin class definition of class MyClass
        cpp_class(MyClass)

            # Class attribute and functions go here

        # End class definition
        cpp_end_class()

    endfunction()

    ct_add_section(NAME [[end_class_name]])
    function("${CMAKETEST_SECTION}")

        # Begin class definition of class MyClass
        cpp_class(MyClass)

            # Class attribute and functions go here

        # End class definition
        cpp_end_class(MyClass)

    endfunction()

    ct_add_section(NAME [[default_ctor]])
    function("${CMAKETEST_SECTION}")

        # Begin class definition of class MyClass
        cpp_class(MyClass)

            # Class attribute and functions go here

        # End class definition
        cpp_end_class()

        # Create an instance of MyClass with the name "my_instance"
        MyClass(CTOR my_instance)

    endfunction()

    ct_add_section(NAME [[custom_ctor]])
    function("${CMAKETEST_SECTION}")

        cpp_class(MyClass)

            # Define a custom constructor
            cpp_constructor(CTOR MyClass int int)
            function("${CTOR}" self a b)
                # Do set up using arguments passed to constructors
            endfunction()
        
        cpp_end_class()
        
        # Create an instance of MyClass using the custom constructor
        MyClass(CTOR my_instance 100 20)

    endfunction()

    ct_add_section(NAME [[kwargs_ctor]])
    function("${CMAKETEST_SECTION}")

        # Define class with some attributes
        cpp_class(MyClass)

            cpp_attr(MyClass attr_a)
            cpp_attr(MyClass attr_b)
            cpp_attr(MyClass attr_c)

        cpp_end_class()
        
        # Create an instance of MyClass using the KWARGS constructor
        MyClass(CTOR my_instance KWARGS attr_a 1 attr_b 2 3 4 attr_c 5 6)

    endfunction()

endfunction()
