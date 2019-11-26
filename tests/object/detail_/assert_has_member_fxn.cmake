include(cmake_test/cmake_test)

ct_add_test("_cpp_object_assert_has_member_fxn")
    include(cmakepp_core/object/detail_/assert_has_member_fxn)
    include(cmakepp_core/object/detail_/ctor)

    _cpp_object_ctor(an_object)

    ct_add_section("No assert unless CMakePP is in debug mode")
        _cpp_object_assert_has_member_fxn("${an_object}" not_a_fxn)
    ct_end_section()

    ct_add_section("Fails if CMakePP is in debug mode and function DNE")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_object_assert_has_member_fxn("${an_object}" not_a_fxn)
        ct_assert_fails_as("Assertion: Class has member function: not_a_fxn")
    ct_end_section()
ct_end_test()
