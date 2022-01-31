include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_get_attr_guts")
function("${test__cpp_object_get_attr_guts}")
    include(cmakepp_lang/object/object)

    ct_add_section(NAME "base_object")
    function("${base_object}")
        _cpp_object_ctor(an_obj obj)
        _cpp_object_set_attr("${an_obj}" foo bar)

        ct_add_section(NAME "get_existing_attribute")
        function("${get_existing_attribute}")
            _cpp_object_get_attr_guts("${an_obj}" result done foo)
            ct_assert_equal(result bar)
            ct_assert_equal(done TRUE)
        endfunction()

        ct_add_section(NAME "get_nonexistent_attribute")
        function("${get_nonexistent_attribute}")
            _cpp_object_get_attr_guts("${an_obj}" result done not_an_attr)
            ct_assert_equal(result "")
            ct_assert_equal(done FALSE)
        endfunction()
    endfunction()

endfunction()

ct_add_test(NAME "test__cpp_object_get_attr")
function("${test__cpp_object_get_attr}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(cmakepp_lang_DEBUG_MODE ON)
        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_get_attr(TRUE result attr)
        endfunction()
    endfunction()

    ct_add_section(NAME "fail_if_attr_not_exist" EXPECTFAIL)
    function("${fail_if_attr_not_exist}")
        _cpp_object_get_attr("${an_obj}" result not_an_attr)
    endfunction()

endfunction()

ct_add_test(NAME "test__cpp_object_set_attr")
function("${test__cpp_object_set_attr}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(cmakepp_lang_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_set_attr(TRUE attr value)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_set_attr("${an_obj}" TRUE value)
        endfunction()
    endfunction()
endfunction()
