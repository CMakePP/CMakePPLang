include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_object_get_attr_guts]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    ct_add_section(NAME [[base_object]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_ctor(an_obj obj)
        _cpp_object_set_attr("${an_obj}" foo bar)

        ct_add_section(NAME [[get_existing_attribute]])
        function("${CMAKETEST_SECTION}")
            _cpp_object_get_attr_guts("${an_obj}" result done foo)
            ct_assert_equal(result bar)
            ct_assert_equal(done TRUE)
        endfunction()

        ct_add_section(NAME [[get_nonexistent_attribute]])
        function("${CMAKETEST_SECTION}")
            _cpp_object_get_attr_guts("${an_obj}" result done not_an_attr)
            ct_assert_equal(result "")
            ct_assert_equal(done FALSE)
        endfunction()
    endfunction()

endfunction()

ct_add_test(NAME [[test__cpp_object_get_attr]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)
        ct_add_section(NAME [[first_arg_obj]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_get_attr(TRUE result attr)
        endfunction()
    endfunction()

    ct_add_section(NAME [[fail_if_attr_not_exist]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        _cpp_object_get_attr("${an_obj}" result not_an_attr)
    endfunction()

endfunction()

ct_add_test(NAME [[test__cpp_object_set_attr]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_obj]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_set_attr(TRUE attr value)
        endfunction()

        ct_add_section(NAME [[second_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_set_attr("${an_obj}" TRUE value)
        endfunction()
    endfunction()
endfunction()
