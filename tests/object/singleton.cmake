include(cmake_test/cmake_test)

ct_add_test("_cpp_object_singleton")
    include(cmakepp_core/object/object)

    _cpp_object_singleton(singleton)

    ct_add_section("attrs")
        _cpp_object_get_meta_attr("${singleton}" the_attrs attrs)
        cpp_map(CTOR corr)
        cpp_map(EQUAL "${corr}" result "${the_attrs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("fxns")
        _cpp_object_get_meta_attr("${singleton}" the_fxns fxns)
        cpp_map(CTOR corr)
        cpp_map(
            SET "${corr}" "_cpp_obj_equal_obj_desc_obj_" [[equal;obj;desc;obj]]
        )
        cpp_map(
            SET "${corr}" "_cpp_obj_serialize_obj_desc_" [[serialize;obj;desc]]
        )

        cpp_map(EQUAL "${corr}" result "${the_fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("sub-objects")
        _cpp_object_get_meta_attr("${singleton}" the_sub_objs sub_objs)
        cpp_map(CTOR corr)
        cpp_map(EQUAL "${corr}" result "${the_sub_objs}")

        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("type")
        _cpp_object_get_meta_attr("${singleton}" result type)
        ct_assert_equal(result obj)
    ct_end_section()

ct_end_test()
