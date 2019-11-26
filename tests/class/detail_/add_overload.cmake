include(cmake_test/cmake_test)

ct_add_test("_cpp_class_add_overload")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)
    _cpp_class_register_member(MyClass a_fxn)
    _cpp_class_get_overloads(overloads MyClass a_fxn)

    ct_add_section("Has no overloads initially")
        cpp_array(CTOR corr)
        cpp_equal(result "${corr}" "${overloads}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Add an overload")
        _cpp_class_add_overload(MyClass a_fxn int bool)
        _cpp_mangle_fxn(mangled_name a_fxn MyClass int bool)
        cpp_array(CTOR corr "${mangled_name}")
        cpp_equal(result "${corr}" "${overloads}")
        ct_assert_equal(result TRUE)

        ct_add_section("Errors if we try to add the overload twice")
            _cpp_class_add_overload(MyClass a_fxn int bool)
            ct_assert_fails_as("Assertion: a_fxn(int, bool) does not exist")
        ct_end_section()
    ct_end_section()
ct_end_test()
