include(cmake_test/cmake_test)

ct_add_test("_cpp_mangle_fxn")
    include(cmakepp_core/function/detail_/mangle_fxn)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be a desc")
            _cpp_mangle_fxn(TRUE hello)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be a desc")
            _cpp_mangle_fxn(hello TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Variadic arguments must be types")
            _cpp_mangle_fxn(hello world foo)
            ct_assert_fails_as("Assertion: foo is type")
        ct_end_section()
    ct_end_section()

    ct_add_section("No arguments")
        _cpp_mangle_fxn(result a_fxn MyClass)
        ct_assert_equal(result "__a_fxn_myclass__")
    ct_end_section()

    ct_add_section("One argument")
        _cpp_mangle_fxn(result a_fxn MyClass int)
        ct_assert_equal(result "__a_fxn_myclass_int__")
    ct_end_section()

    ct_add_section("Two arguments")
        _cpp_mangle_fxn(result a_fxn MyClass int bool)
        ct_assert_equal(result "__a_fxn_myclass_int_bool__")
    ct_end_section()
ct_end_test()
