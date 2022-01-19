include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_get_symbol")
function("${test__cpp_get_symbol}")
    include(cmakepp_core/class/class)
    include(cmakepp_core/object/object)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        _cpp_object_ctor(an_obj obj)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_get_symbol(TRUE result a_list)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_get_symbol("${an_obj}" TRUE a_list)
        endfunction()

        ct_add_section(NAME "third_arg_desc" EXPECTFAIL)
        function("${third_arg_desc}")
            _cpp_object_get_symbol("${an_obj}" result TRUE)
        endfunction()

        ct_add_section(NAME "takes_three_args" EXPECTFAIL)
        function("${takes_three_args}")
            _cpp_object_get_symbol("${an_obj}" result a_list hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "single_class")
    function("${single_class}")
        cpp_class(MyClass)
        _cpp_object_ctor(an_obj MyClass)
        _cpp_object_add_fxn("${an_obj}" a_fxn int)
        _cpp_object_add_fxn("${an_obj}" a_fxn int bool)
        _cpp_object_add_fxn("${an_obj}" another_fxn int)

        ct_add_section(NAME "get_a_fxn_int")
        function("${get_a_fxn_int}")
            set(sig a_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_")
        endfunction()

        ct_add_section(NAME "get_a_fxn_int_bool")
        function("${get_a_fxn_int_bool}")
            set(sig a_fxn int bool)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_bool_")
        endfunction()

        ct_add_section(NAME "get_another_fxn_int")
        function("${get_another_fxn_int}")
            set(sig another_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_another_fxn_int_")
        endfunction()
    endfunction()

    ct_add_section(NAME "single_base_class")
    function("${single_base_class}")
        cpp_class(BaseClass)
        _cpp_object_ctor(base_class BaseClass)
        _cpp_object_add_fxn("${base_class}" a_fxn int)
        _cpp_object_add_fxn("${base_class}" a_fxn int bool)

        cpp_class(MyClass BaseClass)
        _cpp_object_ctor(an_obj MyClass "${base_class}")
        _cpp_object_add_fxn("${an_obj}" a_fxn int)
        _cpp_object_add_fxn("${an_obj}" another_fxn int)


        ct_add_section(NAME "get_MyClass_a_fxn_int")
        function("${get_MyClass_a_fxn_int}")
            set(sig a_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_a_fxn_int_")
        endfunction()

        ct_add_section(NAME "get_BaseClass_a_fxn_int_bool")
        function("${get_BaseClass_a_fxn_int_bool}")
            set(sig a_fxn int bool)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_baseclass_a_fxn_int_bool_")
        endfunction()

        ct_add_section(NAME "get_MyClass_another_fxn_int")
        function("${get_MyClass_another_fxn_int}")
            set(sig another_fxn int)
            _cpp_object_get_symbol("${an_obj}" result sig)
            ct_assert_equal(result "_cpp_myclass_another_fxn_int_")
        endfunction()
    endfunction()
endfunction()
