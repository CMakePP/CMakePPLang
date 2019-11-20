include(cmake_test/cmake_test)

ct_add_test("_cpp_class_register_member")
    include(cmakepp_core/class/class)
    include(cmakepp_core/class/detail_/register_member)

    cpp_class(MyClass)
    cpp_array(CTOR an_array)

    ct_add_section("Class with no prior functions")
        _cpp_class_register_member(MyClass a_fxn)
        _cpp_class_get_fxns(fxns MyClass)
        cpp_map(CTOR corr a_fxn "${an_array}")
        cpp_are_equal(result "${corr}" "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Add two functions")
        _cpp_class_register_member(MyClass a_fxn)
        _cpp_class_register_member(MyClass another_fxn)
        _cpp_class_get_fxns(fxns MyClass)
        cpp_map(CTOR corr a_fxn "${an_array}" another_fxn "${an_array}")
        cpp_are_equal(result "${corr}" "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Fails if type has not been registered")
        _cpp_class_register_member(result NotAClass)
        ct_assert_fails_as("Can not retrieve member functions for type:")
    ct_end_section()

ct_end_test()
