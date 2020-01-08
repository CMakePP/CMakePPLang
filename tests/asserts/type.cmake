include(cmake_test/cmake_test)

ct_add_test("cpp_assert_type")
    include(cmakepp_core/asserts/type)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("Signature")

        ct_add_section("0th argument must be type")
            cpp_assert_type(TRUE TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to type failed.")
        ct_end_section()

        ct_add_section("Takes exactly 2 arguments.")
            cpp_assert_type(bool TRUE hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()

    ct_end_section()

    ct_add_section("Built-in Types")

        ct_add_section("Same type")
            cpp_assert_type(int 1)
        ct_end_section()

        ct_add_section("Wrong type")
            cpp_assert_type(int TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()

    ct_end_section()


    ct_add_section("User-defined types")
        include(cmakepp_core/class/class)
        cpp_class(BaseClass)
        cpp_class(MyClass BaseClass)

        ct_add_section("Works with same classes")
            BaseClass(CTOR a_base_class)
            cpp_assert_type(BaseClass "${a_base_class}")
        ct_end_section()

        ct_add_section("Can upcast")
            MyClass(CTOR my_class)
            cpp_assert_type(BaseClass "${my_class}")
        ct_end_section()

        ct_add_section("Can't downcast")
            BaseClass(CTOR a_base_class)
            cpp_assert_type(MyClass "${a_base_class}")
            ct_assert_fails_as("Assertion: baseclass is convertible to MyClass")
        ct_end_section()
    ct_end_section()
ct_end_test()
