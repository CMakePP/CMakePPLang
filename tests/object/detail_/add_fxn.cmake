include(cmake_test/cmake_test)

ct_add_test("_cpp_object_add_fxn")
    include(cmakepp_core/algorithm/contains)
    include(cmakepp_core/object/detail_/add_fxn)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_fxns)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be obj")
            _cpp_object_add_fxn(TRUE a_fxn)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_object_add_fxn("${an_object}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes only two arguments")
            _cpp_object_add_fxn("${an_object}" a_fxn hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("function does not exist")
        _cpp_object_add_fxn("${an_object}" a_fxn)
        _cpp_object_get_fxns(fxns "${an_object}")
        cpp_contains(result a_fxn "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
