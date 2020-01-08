include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_meta_attr")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be an obj")
            _cpp_object_get_meta_attr(TRUE result my_type)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be a desc")
            _cpp_object_get_meta_attr("${an_obj}" TRUE my_type)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("2nd argument must be a desc")
            _cpp_object_get_meta_attr("${an_obj}" result TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments.")
            _cpp_object_get_meta_attr("${an_obj}" result my_type hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Can get the my_type meta-attribute")
        _cpp_object_get_meta_attr("${an_obj}" result my_type)
        ct_assert_equal(result obj)
    ct_end_section()

    ct_add_section("Get non-existing meta-attribute")
        _cpp_object_get_meta_attr("${an_obj}" result not_an_attr)
        ct_assert_equal(result "")
    ct_end_section()
ct_end_test()
