include(cmake_test/cmake_test)

ct_add_test("_cpp_class_get_overloads")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)

    ct_add_section("Fails if function has not been registered")
        _cpp_class_get_overloads(overloads MyClass a_fxn)
        ct_assert_fails_as("Assertion: a_fxn has been registered")
    ct_end_section()

    ct_add_section("Can get overloads")
        _cpp_class_register_member(MyClass a_fxn)
        _cpp_class_get_overloads(overloads MyClass a_fxn)
        cpp_array(CTOR corr)
        cpp_equal(result "${corr}" "${overloads}")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()
