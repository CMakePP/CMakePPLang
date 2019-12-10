include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_type")
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_type)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            _cpp_object_get_type(TRUE "${an_object}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be obj")
            _cpp_object_get_type(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Takes two args")
            _cpp_object_get_type(result "${an_object}" hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()


    ct_add_section("No derived class")
        _cpp_object_get_type(result "${an_object}")
        ct_assert_equal(result obj)
    ct_end_section()
ct_end_test()
