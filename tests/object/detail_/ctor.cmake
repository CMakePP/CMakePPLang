include(cmake_test/cmake_test)

ct_add_test("_cpp_object_ctor")
    include(cmakepp_core/object/detail_/ctor)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Argument must be desc")
            _cpp_object_ctor(TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes one argument")
            _cpp_object_ctor(an_object hello)
            ct_assert_fails_as("Function takes 1 argument(s), but 2 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("initial state")
        _cpp_object_ctor(an_object)
        include(cmakepp_core/algorithm/equal)
        include(cmakepp_core/utilities/get_global)
        cpp_map(CTOR fxns equal obj)
        cpp_map(CTOR attrs)
        cpp_array(CTOR bases obj)
        cpp_map(CTOR corr attrs "${attrs}"
                          vtable  "${fxns}"
                          bases "${bases}"
                          type "obj"
        )
        cpp_get_global(state "${an_object}")
        cpp_equal(result "${corr}" "${state}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
