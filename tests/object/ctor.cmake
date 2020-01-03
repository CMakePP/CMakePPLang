include(cmake_test/cmake_test)

ct_add_test("_cpp_object_ctor")
    include(cmakepp_core/object/object)
    include(cmakepp_core/types/type_of)
    include(cmakepp_core/utilities/compare_lists)

    ct_add_section("No base class")
        _cpp_object_ctor(an_obj MyClass)

        _cpp_object_serialize("${an_obj}" result)

        ct_add_section("bases meta attr")
            _cpp_object_get_meta_attr("${an_obj}" bases bases)
            ct_assert_equal(bases obj)
        ct_end_section()

        ct_add_section("type meta attr")
            _cpp_object_get_meta_attr("${an_obj}" type type)
            ct_assert_equal(type myclass)
        ct_end_section()

        ct_add_section("typeof(an_obj) == MyClass")
            cpp_type_of(result "${an_obj}")
            ct_assert_equal(result myclass)
        ct_end_section()
    ct_end_section()

    ct_add_section("Single base class")
        _cpp_object_ctor(the_base BaseClass)
        _cpp_object_ctor(an_obj MyClass "${the_base}")

        ct_add_section("bases meta attr")
            _cpp_object_get_meta_attr("${an_obj}" bases bases)
            set(corr obj baseclass)
            cpp_compare_lists(result corr bases)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("type meta attr")
            _cpp_object_get_meta_attr("${an_obj}" type type)
            ct_assert_equal(type myclass)
        ct_end_section()

        ct_add_section("typeof(the_base) == BaseClass")
            cpp_type_of(result "${the_base}")
            ct_assert_equal(result baseclass)
        ct_end_section()

        ct_add_section("typeof(an_obj) == MyClass")
            cpp_type_of(result "${an_obj}")
            ct_assert_equal(result myclass)
        ct_end_section()
    ct_end_section()

    ct_add_section("Multiple base classes")
        _cpp_object_ctor(base1 BaseClass1)
        _cpp_object_ctor(base2 BaseClass2)
        _cpp_object_ctor(an_obj MyClass "${base1}" "${base2}")

        ct_add_section("bases")
            _cpp_object_get_meta_attr("${an_obj}" bases bases)
            set(corr obj baseclass1 baseclass2)
            cpp_compare_lists(result corr bases)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("type")
            _cpp_object_get_meta_attr("${an_obj}" type type)
            ct_assert_equal(type myclass)
        ct_end_section()

        ct_add_section("typeof(base1) == BaseClass1")
            cpp_type_of(result "${base1}")
            ct_assert_equal(result baseclass1)
        ct_end_section()

        ct_add_section("typeof(base2) == BaseClass2")
            cpp_type_of(result "${base2}")
            ct_assert_equal(result baseclass2)
        ct_end_section()

        ct_add_section("typeof(an_obj) == MyClass")
            cpp_type_of(result "${an_obj}")
            ct_assert_equal(result myclass)
        ct_end_section()
    ct_end_section()
ct_end_test()
