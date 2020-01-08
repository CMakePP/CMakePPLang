include(cmake_test/cmake_test)

ct_add_test("_cpp_object_copy")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be obj")
            _cpp_object_copy(TRUE result)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            _cpp_object_copy("${an_obj}" TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 2 arguments")
            _cpp_object_copy("${an_obj}" foo bar)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Base object")

        _cpp_object_set_attr("${an_obj}" foo bar)

        _cpp_object_copy("${an_obj}" a_copy)

        ct_add_section("Are equal")
            _cpp_object_equal("${an_obj}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Are different instances")
            ct_assert_not_equal(an_obj "${a_copy}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Simple inheritance")
        include(cmakepp_core/class/class)

        cpp_class(BaseClass)
            cpp_attr(BaseClass foo bar)

        cpp_class(MyClass BaseClass)
        cpp_get_global(an_obj "MyClass__state")

        _cpp_object_copy("${an_obj}" a_copy)

        ct_add_section("Are equal")
            _cpp_object_equal("${an_obj}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Derived part is a different instance")
            ct_assert_not_equal(an_obj "${a_copy}")
        ct_end_section()

        ct_add_section("Base part is a different instance")
            _cpp_object_get_meta_attr("${an_obj}" this_sub_objs "sub_objs")
            _cpp_object_get_meta_attr("${a_copy}" copy_sub_objs "sub_objs")
            cpp_map(GET "${this_sub_objs}" this_base "BaseClass")
            cpp_map(GET "${copy_sub_objs}" copy_base "BaseClass")
            ct_assert_not_equal(copy_base "${this_base}")
        ct_end_section()
    ct_end_section()
ct_end_test()
