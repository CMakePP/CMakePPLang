include(cmake_test/cmake_test)

ct_add_test("_cpp_object_serialize")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be obj")
            _cpp_object_serialize(TRUE result)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            _cpp_object_serialize("${an_obj}" TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 2 arguments.")
            _cpp_object_serialize("${an_obj}" result hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Serialized Value")
        _cpp_object_serialize("${an_obj}" result)
        set(corr "{ \"${an_obj}\" : { \"_cpp_attrs\" : { }, \"_cpp_fxns\" : { ")
        string(APPEND corr "}, \"_cpp_sub_objs\" : { }, \"_cpp_my_type\" : ")
        string(APPEND corr "\"obj\" } }")
        ct_assert_equal(result "${corr}")
    ct_end_section()
ct_end_test()

ct_add_test("_cpp_object_print")
    include(cmakepp_core/object/object)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be an obj")
            _cpp_object_print(TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("Takes exactly one argument.")
            _cpp_object_print("${__CMAKEPP_CORE_OBJECT_SINGLETON__}" hello)
            ct_assert_fails_as("Function takes 1 argument(s), but 2 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Prints value")
        _cpp_object_print("${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_prints("{ \"_cpp_attrs\" : { }, ")
    ct_end_section()
ct_end_test()
