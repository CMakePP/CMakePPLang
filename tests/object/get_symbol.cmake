include(cmake_test/cmake_test)

ct_add_test("_cpp_get_symbol")
    include(cmakepp_core/class/class)
    include(cmakepp_core/object/object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        _cpp_object_ctor(an_obj obj)

        ct_add_section("0th argument must be an obj")
            _cpp_object_get_symbol(TRUE result a_list)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be a desc")
            _cpp_object_get_symbol("${an_obj}" TRUE a_list)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("2nd argument must be a desc")
            _cpp_object_get_symbol("${an_obj}" result TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments")
            _cpp_object_get_symbol("${an_obj}" result a_list hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Single class")
        cpp_class(MyClass)
        _cpp_object_ctor(an_obj MyClass)
        _cpp_object_add_fxn("${an_obj}" a_fxn int)
        _cpp_object_add_fxn("${an_obj}" a_fxn int bool)
        _cpp_object_add_fxn("${an_obj}" another_fxn int)

        ct_add_section("Get a_fxn(int)")
            set(sig a_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_")
        ct_end_section()

        ct_add_section("Get a_fxn(int, bool)")
            set(sig a_fxn int bool)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_bool_")
        ct_end_section()

        ct_add_section("Get another_fxn(int)")
            set(sig another_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_another_fxn_int_")
        ct_end_section()
    ct_end_section()

    ct_add_section("Single base class")
        cpp_class(BaseClass)
        _cpp_object_ctor(base_class BaseClass)
        _cpp_object_add_fxn("${base_class}" a_fxn int)
        _cpp_object_add_fxn("${base_class}" a_fxn int bool)

        cpp_class(MyClass BaseClass)
        _cpp_object_ctor(an_obj MyClass "${base_class}")
        _cpp_object_add_fxn("${an_obj}" a_fxn int)
        _cpp_object_add_fxn("${an_obj}" another_fxn int)


        ct_add_section("Gets MyClass::a_fxn(int)")
            set(sig a_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_")
        ct_end_section()

        ct_add_section("Get BaseClass::a_fxn(int, bool)")
            set(sig a_fxn int bool)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_baseclass_a_fxn_int_bool_")
        ct_end_section()

        ct_add_section("Get MyClass::another_fxn(int)")
            set(sig another_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_another_fxn_int_")
        ct_end_section()
    ct_end_section()
ct_end_test()
