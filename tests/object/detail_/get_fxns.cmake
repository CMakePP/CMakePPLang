include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_fxns")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/add_fxn)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_fxns)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            _cpp_object_get_fxns(TRUE "${an_object}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be obj")
            _cpp_object_get_fxns(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Only takes two arguments")
            _cpp_object_get_fxns(result "${an_object}" hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Default object")
        cpp_map(CTOR corr)
        _cpp_object_get_fxns(fxns "${an_object}")
        cpp_equal(result "${corr}" "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Object with a function")
        _cpp_object_add_fxn("${an_object}" a_fxn)
        _cpp_object_get_fxns(fxns "${an_object}")
        cpp_map(CTOR overloads)
        cpp_map(CTOR corr a_fxn "${overloads}")
        cpp_equal(result "${corr}" "${fxns}")
    ct_end_section()
ct_end_test()
