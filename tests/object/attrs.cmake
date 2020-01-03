include(cmake_test/cmake_test)

ct_add_test("get/set object attrs")
    include(cmakepp_core/object/object)

    ct_add_section("Base object")
        _cpp_object_ctor(an_obj MyClass)
        _cpp_object_set_attr("${an_obj}" foo bar)
        ct_add_section("Get existing attribute")
            _cpp_object_get_attr("${an_obj}" result foo)
            ct_assert_equal(result bar)
        ct_end_section()

        ct_add_section("Get non-existent attribute")
            _cpp_object_get_attr("${an_obj}" result not_an_attr)
            ct_assert_fails_as("Instance has no attribute not_an_attr")
        ct_end_section()
    ct_end_section()

    ct_add_section("Simple inheritance")
        _cpp_object_ctor(base BaseClass)
        _cpp_object_set_attr("${base}" foo bar)
        _cpp_object_set_attr("${base}" hello world)

        _cpp_object_ctor(an_obj MyClass "${base}")
        _cpp_object_set_attr("${an_obj}" foo 42)
        _cpp_object_set_attr("${an_obj}" alice bob)

        ct_add_section("Can get base attribute")
            _cpp_object_get_attr("${an_obj}" result hello)
            ct_assert_equal(result world)
        ct_end_section()

        ct_add_section("Can get derived attribute")
            _cpp_object_get_attr("${an_obj}" result alice)
            ct_assert_equal(result bob)
        ct_end_section()

        ct_add_section("Overrides base attribute")
            _cpp_object_get_attr("${an_obj}" result foo)
            ct_assert_equal(result 42)
        ct_end_section()

        ct_add_section("Get non-existent attribute")
            _cpp_object_get_attr("${an_obj}" result not_an_attr)
            ct_assert_fails_as("Instance has no attribute not_an_attr")
        ct_end_section()
    ct_end_section()

    ct_add_section("Multiple inheritance")
        _cpp_object_ctor(base1 BaseClass1)
        _cpp_object_set_attr("${base1}" foo bar)

        _cpp_object_ctor(base2 BaseClass2)
        _cpp_object_set_attr("${base2}" hello world)

        _cpp_object_ctor(an_obj MyClass "${base1}" "${base2}")
        _cpp_object_set_attr("${an_obj}" alice bob)

        ct_add_section("Can get attribute from first base class")
            _cpp_object_get_attr("${an_obj}" result foo)
            ct_assert_equal(result bar)
        ct_end_section()

        ct_add_section("Can get attribute from second base class")
            _cpp_object_get_attr("${an_obj}" result hello)
            ct_assert_equal(result world)
        ct_end_section()

        ct_add_section("Can get derived attribute")
            _cpp_object_get_attr("${an_obj}" result alice)
            ct_assert_equal(result bob)
        ct_end_section()

        ct_add_section("Overrides base attribute")
            _cpp_object_set_attr("${an_obj}" foo 42)
            _cpp_object_get_attr("${an_obj}" result foo)
            ct_assert_equal(result 42)
        ct_end_section()

        ct_add_section("Get non-existent attribute")
            _cpp_object_get_attr("${an_obj}" result not_an_attr)
            ct_assert_fails_as("Instance has no attribute not_an_attr")
        ct_end_section()
    ct_end_section()
ct_end_test()
