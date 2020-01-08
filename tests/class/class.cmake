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
ct_end_test()

ct_add_test("cpp_attr")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be class")
            cpp_attr(TRUE an_attr)
            ct_assert_fails_as("Assertion: bool is convertible to class")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            cpp_attr(Myclass TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc")
        ct_end_section()
    ct_end_section()
ct_end_test()
