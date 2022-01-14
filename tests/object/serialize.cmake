include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_serialize")
function("${test__cpp_object_serialize}")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_serialize(TRUE result)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_serialize("${an_obj}" TRUE)
        endfunction()

        ct_add_section(NAME "takes_two_args" EXPECTFAIL)
        function("${takes_two_args}")
            _cpp_object_serialize("${an_obj}" result hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "serialized_val")
    function("${serialized_val}")
        _cpp_object_serialize("${an_obj}" result)
        set(corr "{ \"${an_obj}\" : { \"_cpp_attrs\" : { }, \"_cpp_fxns\" : { ")
        string(APPEND corr "}, \"_cpp_sub_objs\" : { }, \"_cpp_my_type\" : ")
        string(APPEND corr "\"obj\" } }")
        ct_assert_equal(result "${corr}")
    endfunction()
endfunction()

ct_add_test(NAME "test__cpp_object_print")
function("${test__cpp_object_print}")
    include(cmakepp_core/object/object)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_print(TRUE)
        endfunction()

        ct_add_section(NAME "takes_one_arg" EXPECTFAIL)
        function("${takes_one_arg}")
            _cpp_object_print("${__CMAKEPP_CORE_OBJECT_SINGLETON__}" hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "print_val")
    function("${print_val}")
        _cpp_object_print("${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_prints("{ \"_cpp_attrs\" : { }, ")
    endfunction()
endfunction()
