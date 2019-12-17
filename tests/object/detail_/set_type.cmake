include(cmake_test/cmake_test)

ct_add_test("_ct_object_set_type")
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)
    include(cmakepp_core/object/detail_/set_type)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg0 must be obj")
            _cpp_object_set_type(TRUE the_type)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg1 must be desc")
            _cpp_object_set_type("${an_object}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Function takes 2 arguments")
            _cpp_object_set_type("${an_object}" the_type hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()


    ct_add_section("Correct value")
        _cpp_object_set_type("${an_object}" the_type)
        _cpp_object_get_type("${an_object}" result)
        ct_assert_equal(result the_type)
    ct_end_section()
ct_end_test()
