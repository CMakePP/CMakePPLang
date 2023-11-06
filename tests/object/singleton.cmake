include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_object_singleton]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_singleton(singleton)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_singleton(TRUE)
        endfunction()

        ct_add_section(NAME [[takes_one_arg]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_singleton(result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME [[attrs]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_get_meta_attr("${singleton}" the_attrs attrs)
        cpp_map(CTOR corr)
        cpp_map(EQUAL "${corr}" result "${the_attrs}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[fxns]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_get_meta_attr("${singleton}" the_fxns fxns)
        cpp_map(CTOR corr)
        cpp_map(
            SET "${corr}" "_cpp_obj_equal_obj_desc_obj_" [[equal;obj;desc;obj]]
        )
        cpp_map(
            SET "${corr}" "_cpp_obj_serialize_obj_desc_" [[serialize;obj;desc]]
        )
        cpp_map(
            SET "${corr}" "_cpp_obj_ctor_desc_" [[ctor;desc]]
        )

        cpp_map(EQUAL "${corr}" result "${the_fxns}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[sub_objects]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_get_meta_attr("${singleton}" the_sub_objs sub_objs)
        cpp_map(CTOR corr)
        cpp_map(EQUAL "${corr}" result "${the_sub_objs}")

        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[types]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_get_meta_attr("${singleton}" result my_type)
        ct_assert_equal(result obj)
    endfunction()

endfunction()
