include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_state")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)

    _cpp_object_ctor(an_object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be obj")
            _cpp_object_get_state(TRUE result vtable)
            ct_assert_fails_as("Assertion: TRUE is obj")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_object_get_state("${an_object}" TRUE vtable)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg3 must be desc")
            _cpp_object_get_state("${an_object}" result TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Takes 3 arguments")
            _cpp_object_get_state("${an_object}" result vtable hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()


    ct_add_section("Vtable")
        ct_add_section("Default object")
            cpp_map(CTOR corr)
            _cpp_object_get_state("${an_object}" vtable vtable)
            cpp_equal(result "${vtable}" "${corr}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Attributes")
        ct_add_section("Default object")
            cpp_map(CTOR corr)
            _cpp_object_get_state("${an_object}" attrs attrs)
            cpp_equal(result "${attrs}" "${corr}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Bases")
        ct_add_section("Default object")
            cpp_map(CTOR corr)
            _cpp_object_get_state("${an_object}" bases bases)
            cpp_equal(result "${bases}" "${corr}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Type")
        ct_add_section("Default object")
            cpp_map(CTOR corr)
            _cpp_object_get_state("${an_object}" type type)
            cpp_equal(result "${type}" "${corr}")
        ct_end_section()
    ct_end_section()

ct_end_test()

ct_add_test("_cpp_object_get_vtable")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)

    _cpp_object_ctor(an_object)

    _cpp_object_get_state("${an_object}" corr vtable)
    _cpp_object_get_vtable("${an_object}" vtable)
    cpp_equal(result "${vtable}" "${corr}")
    ct_assert_equal(result TRUE)
ct_end_test()

ct_add_test("_cpp_object_get_attrs")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)

    _cpp_object_ctor(an_object)

    _cpp_object_get_state("${an_object}" corr attrs)
    _cpp_object_get_attrs("${an_object}" attrs)
    cpp_equal(result "${attrs}" "${corr}")
    ct_assert_equal(result TRUE)
ct_end_test()

ct_add_test("_cpp_object_get_bases")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)

    _cpp_object_ctor(an_object)

    _cpp_object_get_state("${an_object}" corr bases)
    _cpp_object_get_bases("${an_object}" bases)
    cpp_equal(result "${bases}" "${corr}")
    ct_assert_equal(result TRUE)
ct_end_test()

ct_add_test("_cpp_object_get_type")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_state)

    _cpp_object_ctor(an_object)

    _cpp_object_get_state("${an_object}" corr type)
    _cpp_object_get_type("${an_object}" type)
    cpp_equal(result "${type}" "${corr}")
    ct_assert_equal(result TRUE)
ct_end_test()
