include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_object_serialize]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_obj]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_serialize(TRUE result)
        endfunction()

        ct_add_section(NAME [[second_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_serialize("${an_obj}" TRUE)
        endfunction()

        ct_add_section(NAME [[takes_two_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_serialize("${an_obj}" result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME [[serialized_val]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_serialize("${an_obj}" result)
        set(corr "{ \"${an_obj}\" : { \"_cpp_attrs\" : { }, \"_cpp_fxns\" : { ")
        string(APPEND corr "}, \"_cpp_sub_objs\" : { }, \"_cpp_my_type\" : ")
        string(APPEND corr "\"obj\" } }")
        ct_assert_equal(result "${corr}")
    endfunction()
endfunction()

ct_add_test(NAME [[test__cpp_object_print]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/object/object)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_obj]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_print(TRUE)
        endfunction()

        ct_add_section(NAME [[takes_one_arg]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            _cpp_object_print("${__CMAKEPP_LANG_OBJECT_SINGLETON__}" hello)
        endfunction()
    endfunction()

    ct_add_section(NAME [[print_val]])
    function("${CMAKETEST_SECTION}")
        _cpp_object_print("${__CMAKEPP_LANG_OBJECT_SINGLETON__}")
        ct_assert_prints("{ \"_cpp_attrs\" : { }, ")
    endfunction()
endfunction()
