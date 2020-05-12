include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_attr_guts")
    include(cmakepp_core/object/object)

    ct_add_section("Base object")
        _cpp_object_ctor(an_obj obj)
        _cpp_object_set_attr("${an_obj}" foo bar)

        ct_add_section("Get existing attribute")
            _cpp_object_get_attr_guts("${an_obj}" result done foo)
            ct_assert_equal(result bar)
            ct_assert_equal(done TRUE)
        ct_end_section()

        ct_add_section("Get non-existent attribute")
            _cpp_object_get_attr_guts("${an_obj}" result done not_an_attr)
            ct_assert_equal(result "")
            ct_assert_equal(done FALSE)
        ct_end_section()
    ct_end_section()

ct_end_test()

ct_add_test("_cpp_object_get_attr")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("0th argument must be obj")
            _cpp_object_get_attr(TRUE result attr)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()
    ct_end_section()

    ct_add_section("Fails if attribute does not exist")
        _cpp_object_get_attr("${an_obj}" result not_an_attr)
        ct_assert_fails_as("Instance has no attribute not_an_attr")
    ct_end_section()

    ct_add_section("Fails if attribute does not exist")
        _cpp_object_get_attr("${an_obj}" result not_an_attr)
        ct_assert_fails_as("Instance has no attribute not_an_attr")
    ct_end_section()
ct_end_test()

ct_add_test("_cpp_object_set_attr")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be obj")
            _cpp_object_set_attr(TRUE attr value)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            _cpp_object_set_attr("${an_obj}" TRUE value)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments")
            _cpp_object_set_attr("${an_obj}" attr value hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()
ct_end_test()
