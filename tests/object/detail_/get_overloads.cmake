include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_overloads")
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_overloads)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            _cpp_object_get_overloads(TRUE "${an_object}" a_fxn)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be obj")
            _cpp_object_get_overloads(overloads TRUE a_fxn)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg3 must be desc")
            _cpp_object_get_overloads(overloads "${an_object}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes only 3 arguments")
            _cpp_object_get_overloads(overloads "${an_object}" a_fxn hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Fails if function is not in vtable")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_object_get_overloads(overloads "${an_object}" a_fxn)
        ct_assert_fails_as("Assertion: Class has member function a_fxn")
    ct_end_section()

    ct_add_section("Function exists")
        include(cmakepp_core/object/detail_/add_fxn)
        _cpp_object_add_fxn("${an_object}" a_fxn)

        ct_add_section("No overloads")
            _cpp_object_get_overloads(overloads "${an_object}" a_fxn)
            cpp_map(CTOR corr)
            cpp_equal(result "${corr}" "${overloads}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()
