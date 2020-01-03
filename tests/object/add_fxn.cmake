include(cmake_test/cmake_test)

ct_add_test("_cpp_object_add_fxn")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_object MyClass)

    ct_add_section("No arguments")
        _cpp_object_add_fxn("${an_object}" a_fxn)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_)
        ct_end_section()
    ct_end_section()

    ct_add_section("Pure variadic")
        _cpp_object_add_fxn("${an_object}" a_fxn args)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_args_)
        ct_end_section()
    ct_end_section()

    ct_add_section("Non-variadic one argument")
        _cpp_object_add_fxn("${an_object}" a_fxn int)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_int_)
        ct_end_section()
    ct_end_section()

    ct_add_section("Variadic one argument")
        _cpp_object_add_fxn("${an_object}" a_fxn int args)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_int_args_)
        ct_end_section()
    ct_end_section()

    ct_add_section("Non-variadic two arguments")
        _cpp_object_add_fxn("${an_object}" a_fxn int bool)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_int_bool_)
        ct_end_section()
    ct_end_section()

    ct_add_section("Variadic two arguments")
        _cpp_object_add_fxn("${an_object}" a_fxn int bool args)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn _cpp_myclass_a_fxn_int_bool_args_)
        ct_end_section()
    ct_end_section()
ct_end_test()
