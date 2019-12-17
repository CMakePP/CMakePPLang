include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_mangled_name")
    include(cmakepp_core/object/detail_/add_function)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/mangled_name)

    _cpp_object_ctor(an_object)
    _cpp_object_add_function("${an_object}" a_fxn a_base)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg0 must be obj")
            _cpp_object_get_mangled_name(TRUE result a_fxn)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg1 must be desc")
            _cpp_object_get_mangled_name("${an_object}" TRUE a_fxn)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_object_get_mangled_name("${an_object}" result TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes 3 arguments")
            _cpp_object_get_mangled_name("${an_object}" result a_fxn hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Correct value")
        _cpp_object_get_mangled_name("${an_object}" result a_fxn)
        ct_assert_equal(result "a_base_a_fxn")
    ct_end_section()

ct_end_test()
