include(cmake_test/cmake_test)

ct_add_test("cpp_class")
    include(cmakepp_core/class/class)
    include(cmakepp_core/types/types)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_class(TRUE)
        ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
    ct_end_section()

    ct_add_section("Default class")
        cpp_class(MyClass)
        cpp_get_global(default "myclass__state")

        ct_add_section("MyClass can be cast to obj")
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("typeof(MyClass) == class")
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        ct_end_section()
    ct_end_section()

    ct_add_section("Class with a base class")
        cpp_class(BaseClass)
        cpp_class(MyClass BaseClass)

        ct_add_section("MyClass can be cast to BaseClass")
            cpp_implicitly_convertible(result MyClass BaseClass)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to obj")
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("typeof(MyClass) == class")
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        ct_end_section()
    ct_end_section()

    ct_add_section("Class with two base classes")
        cpp_class(BaseClass1)
        cpp_class(BaseClass2)
        cpp_class(MyClass BaseClass1 BaseClass2)

        ct_add_section("MyClass can be cast to BaseClass1")
            cpp_implicitly_convertible(result MyClass BaseClass1)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to BaseClass2")
            cpp_implicitly_convertible(result MyClass BaseClass2)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to obj")
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("typeof(MyClass) == class")
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        ct_end_section()
    ct_end_section()

    ct_add_section("Deep class hierarchy")
        cpp_class(BaseBaseClass)
        cpp_class(BaseClass BaseBaseClass)
        cpp_class(MyClass BaseClass)

        ct_add_section("BaseClass can be cast to BaseBaseClass")
            cpp_implicitly_convertible(result BaseClass BaseBaseClass)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to BaseBaseClass")
            cpp_implicitly_convertible(result MyClass BaseBaseClass)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to BaseClass")
            cpp_implicitly_convertible(result MyClass BaseClass)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("MyClass can be cast to obj")
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("typeof(MyClass) == class")
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        ct_end_section()
    ct_end_section()
ct_end_test()

ct_add_test("cpp_member")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be desc")
            cpp_member(TRUE Myclass)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("1st argument must be class")
            cpp_member(a_fxn TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to class")
        ct_end_section()
    ct_end_section()

    cpp_class(MyClass)
        cpp_member(fxn_a MyClass int)
        function("${fxn_a}" self a)
            message("a = ${a}")
        endfunction()

        cpp_member(fxn_b MyClass int int)
        function("${fxn_b}" self a b)
            message("a = ${a}, b = ${b}")
        endfunction()

        cpp_member(fxn_c MyClass int desc)
        function("${fxn_c}" self a b)
            message("a = ${a}, b = ${b}")
        endfunction()
    cpp_end_class()

    ct_add_section("Member functions with a single parameter can be called")
        MyClass(CTOR my_instance)
        MyClass(fxn_a "${my_instance}" 1)
        ct_assert_prints("a = 1")
    ct_end_section()

    ct_add_section("Member functions with multiple parameters can be called")
        MyClass(CTOR my_instance)
        MyClass(fxn_b "${my_instance}" 1 2)
        ct_assert_prints("a = 1, b = 2")
    ct_end_section()

    ct_add_section("Member functions with desc parameters can be called")
        MyClass(CTOR my_instance)
        MyClass(fxn_c "${my_instance}" 1 "This is a string.")
        ct_assert_prints("a = 1, b = This is a string.")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_attr")
    include(cmakepp_core/class/class)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_class(MyClass)

        ct_add_section("0th argument must be class")
            cpp_attr(TRUE an_attr)
            ct_assert_fails_as("Assertion: bool is convertible to class")
        ct_end_section()
    ct_end_section()

    ct_add_section("Can retrieve attributes")
        # Declare class with functions for getting and printing attributes
        cpp_class(MyClass)
            cpp_attr(MyClass a 1)
            cpp_attr(MyClass b 2)
            cpp_attr(MyClass c 3)
            cpp_attr(MyClass d 4)

            # Get multiple attributes one at a time
            cpp_member(get_single_attrs MyClass)
            function("${get_single_attrs}" self)
                MyClass(GET "${self}" _gsa_a a)
                MyClass(GET "${self}" _gsa_d d)
                message("${_gsa_a}, ${_gsa_d}")
            endfunction()

            # Get multiple attributes and return using prefix
            cpp_member(get_multiple_attrs MyClass)
            function("${get_multiple_attrs}" self)
                MyClass(GET "${self}" _gma a b c d)
                message("${_gma_a}, ${_gma_b}, ${_gma_c}, ${_gma_d}")
            endfunction()
        cpp_end_class()

        # Create instance
        MyClass(CTOR my_instance)

        ct_add_section("Can retrieve a single attribute in one call")
            MyClass(get_single_attrs "${my_instance}")
            ct_assert_prints("1, 4")
        ct_end_section()

        ct_add_section("Can retrieve multiple attributes in one call")
            MyClass(get_multiple_attrs "${my_instance}")
            ct_assert_prints("1, 2, 3, 4")
        ct_end_section()
    ct_end_section()
ct_end_test()

ct_add_test("cpp_constructor")
    include(cmakepp_core/class/class)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be desc")
            cpp_constructor(TRUE Myclass)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("1st argument must be class")
            cpp_constructor(a_fxn TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to class")
        ct_end_section()
    ct_end_section()

    ct_add_section("No custom constructor defined")
        # Define class with no CTOR and one member function
        cpp_class(MyClass)
            cpp_member(MyFunc MyClass int)
            function("${MyFunc}" self a)
                    message("a = ${a}")
            endfunction()
        cpp_end_class()

        # Create instance and call MyFunc
        MyClass(CTOR my_instance)
        MyClass(MyFunc "${my_instance}" 1)

        # Test that MyFunc was called
        ct_assert_prints("a = 1")
    ct_end_section()

    ct_add_section("Single custom constructor defined")
        # Define class with one CTOR, one attribute, and one member function
        cpp_class(MyClass)
            cpp_attr(MyClass my_attr 1)

            cpp_constructor(CTOR MyClass)
            function("${CTOR}" self)
                MyClass(SET "${self}" my_attr 2)
            endfunction()

            cpp_member(MyFunc MyClass)
            function("${MyFunc}" self)
                MyClass(GET "${self}" attr my_attr)
                message("my_attr = ${attr}")
            endfunction()
        cpp_end_class()

        # Create instance and call MyFunc
        MyClass(CTOR my_instance)
        MyClass(MyFunc "${my_instance}")

        # Test that the CTOR was called
        ct_assert_prints("my_attr = 2")
    ct_end_section()

    ct_add_section("Multiple custom constructor defined")
        # Define class with one CTOR, one attribute, and one member function
        cpp_class(MyClass)
            cpp_attr(MyClass my_attr 1)

            cpp_constructor(CTOR MyClass)
            function("${CTOR}" self)
                # Change value of my_attr
                MyClass(SET "${self}" my_attr 2)
            endfunction()

            cpp_constructor(CTOR MyClass int)
            function("${CTOR}" self a)
                # Change value of my_attr
                MyClass(SET "${self}" my_attr "${a}")
            endfunction()

            cpp_member(MyFunc MyClass)
            function("${MyFunc}" self)
                # Get and print value of my_attr
                MyClass(GET "${self}" attr my_attr)
                message("my_attr = ${attr}")
            endfunction()
        cpp_end_class()

        ct_add_section("1st constructor with no parameters can be called")
            # Create instance and call MyFunc
            MyClass(CTOR my_instance)
            MyClass(MyFunc "${my_instance}")

            # Test that the 1st CTOR was called
            ct_assert_prints("my_attr = 2")
        ct_end_section()

        ct_add_section("2nd constructor with an int parameter can be called")
            # Create instance and call MyFunc
            MyClass(CTOR my_instance 3)
            MyClass(MyFunc "${my_instance}")

            # Test that the 2nd CTOR was called
            ct_assert_prints("my_attr = 3")
        ct_end_section()

    ct_end_section()

    ct_add_section("KWARGS Constructor")
        # Define class with three attributes and one function to print them out
        cpp_class(MyClass)
            cpp_attr(MyClass a 10)
            cpp_attr(MyClass b 20)
            cpp_attr(MyClass c 30)

            cpp_member(MyFunc MyClass)
            function("${MyFunc}" self)
                MyClass(GET "${self}" _gma a b c)
                message("${_gma_a}, ${_gma_b}, ${_gma_c}")
            endfunction()
        cpp_end_class()

        ct_add_section("Sets attributes")
            # Create instance using KWARGS CTOR and call MyFunc
            MyClass(CTOR my_instance KWARGS a 1 b 2 3 4 c 5 6)
            MyClass(MyFunc "${my_instance}")

            # Test that the KWARGS CTOR set attributes correctly
            ct_assert_prints("1, 2;3;4, 5;6")
        ct_end_section()

        ct_add_section("Raises error when first KWARG is not attribute name")
            MyClass(CTOR my_instance KWARGS not_an_attr 1 b 2 3 4 c 5 6)
            ct_assert_fails_as("Instance has no attribute not_an_attr")
        ct_end_section()
    ct_end_section()

    ct_add_section("Calling base class constructor")
        # Define ParentClass
        cpp_class(ParentClass)
            cpp_attr(ParentClass parent_attr a)

            cpp_constructor(CTOR ParentClass)
            function("${CTOR}" self)
                # Change value of parent_attr
                ParentClass(SET "${self}" parent_attr b)
            endfunction()
        cpp_end_class()

        # Define DerivedClass
        cpp_class(DerivedClass ParentClass)
            cpp_attr(DerivedClass derived_attr 1)

            cpp_constructor(CTOR DerivedClass)
            function("${CTOR}" self)
                # Call CTOR of ParentClass
                ParentClass(CTOR "${self}")
                # Change value of derived_attr
                DerivedClass(SET "${self}" derived_attr 2)
            endfunction()

            cpp_member(MyFunc DerivedClass)
            function("${MyFunc}" self)
                DerivedClass(GET "${self}" p_attr parent_attr)
                DerivedClass(GET "${self}" d_attr derived_attr)
                message("parent_attr = ${p_attr}, derived_attr = ${d_attr}")
            endfunction()
        cpp_end_class()

        # Create instance and call MyFunc
        DerivedClass(CTOR my_instance)
        DerivedClass(MyFunc "${my_instance}")

        # Test the the 2nd CTOR was called
        ct_assert_prints("parent_attr = b, derived_attr = 2")
    ct_end_section()

    ct_add_section("No suitable overload")
        # Define MyClass
        cpp_class(MyClass)
        cpp_end_class()

        # Call CTOR with args passed
        MyClass(CTOR my_instance 1 2 3)

        # Ensure error is thrown
        ct_assert_fails_as("No suitable overload of ctor(desc, int, int, int)")
    ct_end_section()

    ct_add_section("Calling CTOR of non-parent class")
        # Create classes with inheritance
        cpp_class(ParentClass)
            cpp_constructor(CTOR ParentClass)
            function("${CTOR}" self)
            endfunction()
        cpp_end_class()

        cpp_class(NonParentClass)
            cpp_constructor(CTOR NonParentClass)
            function("${CTOR}" self)
            endfunction()
        cpp_end_class()

        cpp_class(DerivedClass ParentClass)
            cpp_constructor(CTOR DerivedClass)
            function("${CTOR}" self)
                NonParentClass(CTOR "${self}")
            endfunction()
        cpp_end_class()

        # Call CTOR
        DerivedClass(CTOR my_instance)

        # Ensure error is thrown
        ct_assert_fails_as("Constructor for type NonParentClass called from")
    ct_end_section()

ct_end_test()
