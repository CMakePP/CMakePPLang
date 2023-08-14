include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_add_fxn")
function("${test__cpp_object_add_fxn}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_object obj)
    cpp_map(CTOR corr)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_add_fxn(TRUE a_fxn)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_add_fxn("${an_object}" TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "no_args")
    function("${no_args}")
        _cpp_object_add_fxn("${an_object}" a_fxn)
        set(corr_mn _cpp_obj_a_fxn_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "pure_variadic")
    function("${pure_variadic}")
        _cpp_object_add_fxn("${an_object}" a_fxn args)
        set(corr_mn _cpp_obj_a_fxn_args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "nonvariadic_one_arg")
    function("${nonvariadic_one_arg}")
        _cpp_object_add_fxn("${an_object}" a_fxn int)
        set(corr_mn _cpp_obj_a_fxn_int_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "nonvariadic_one_ptr_arg")
    function("${nonvariadic_one_ptr_arg}")
        _cpp_object_add_fxn("${an_object}" a_fxn int*)
        set(corr_mn _cpp_obj_a_fxn_int__)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int*)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "variadic_one_arg")
    function("${variadic_one_arg}")
        _cpp_object_add_fxn("${an_object}" a_fxn int args)
        set(corr_mn _cpp_obj_a_fxn_int_args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "variadic_one_ptr_arg")
    function("${variadic_one_ptr_arg}")
        _cpp_object_add_fxn("${an_object}" a_fxn int* args)
        set(corr_mn _cpp_obj_a_fxn_int__args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int* args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "nonvariadic_two_args")
    function("${nonvariadic_two_args}")
        _cpp_object_add_fxn("${an_object}" a_fxn int bool)
        set(corr_mn _cpp_obj_a_fxn_int_bool_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int bool)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "nonvariadic_two_ptr_args")
    function("${nonvariadic_two_ptr_args}")
        _cpp_object_add_fxn("${an_object}" a_fxn int* bool*)
        set(corr_mn _cpp_obj_a_fxn_int__bool__)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int* bool*)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "nonvariadic_two_args_one_ptr")
    function("${nonvariadic_two_args_one_ptr}")
        _cpp_object_add_fxn("${an_object}" a_fxn int* bool)
        set(corr_mn _cpp_obj_a_fxn_int__bool_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int* bool)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "variadic_two_args")
    function("${variadic_two_args}")
        _cpp_object_add_fxn("${an_object}" a_fxn int bool args)
        set(corr_mn _cpp_obj_a_fxn_int_bool_args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int bool args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "variadic_two_ptr_args")
    function("${variadic_two_ptr_args}")
        _cpp_object_add_fxn("${an_object}" a_fxn int* bool* args)
        set(corr_mn _cpp_obj_a_fxn_int__bool__args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int* bool* args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "variadic_two_args_one_ptr")
    function("${variadic_two_args_one_ptr}")
        _cpp_object_add_fxn("${an_object}" a_fxn int* bool args)
        set(corr_mn _cpp_obj_a_fxn_int__bool_args_)

        ct_add_section(NAME "returns_mangled_name")
        function("${returns_mangled_name}")
            ct_assert_equal(a_fxn "${corr_mn}")
        endfunction()

        ct_add_section(NAME "adds_correct_value")
        function("${adds_correct_value}")
            set(args a_fxn int* bool args)
            cpp_map(SET "${corr}" "${corr_mn}" "${args}")
            _cpp_object_get_meta_attr("${an_object}" fxns fxns)
            cpp_map(EQUAL "${corr}" result "${fxns}")
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()
endfunction()
