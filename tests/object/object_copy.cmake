include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_copy")
function("${test__cpp_object_copy}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_copy(TRUE result)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_copy("${an_obj}" TRUE)
        endfunction()

        ct_add_section(NAME "takes_two_args" EXPECTFAIL)
        function("${takes_two_args}")
            _cpp_object_copy("${an_obj}" foo bar)
        endfunction()
    endfunction()

    ct_add_section(NAME "base_object")
    function("${base_object}")

        _cpp_object_set_attr("${an_obj}" foo bar)

        _cpp_object_copy("${an_obj}" a_copy)

        ct_add_section(NAME "are_equal")
        function("${are_equal}")
            _cpp_object_equal("${an_obj}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "are_diff_instances")
        function("${are_diff_instances}")
            ct_assert_not_equal(an_obj "${a_copy}")
        endfunction()
    endfunction()

    ct_add_section(NAME "simple_inheritance")
    function("${simple_inheritance}")
        include(cmakepp_lang/class/class)

        cpp_class(BaseClass)
            cpp_attr(BaseClass foo bar)

        cpp_class(MyClass BaseClass)
        cpp_get_global(an_obj "MyClass__state")

        _cpp_object_copy("${an_obj}" a_copy)

        ct_add_section(NAME "are_equal")
        function("${are_equal}")
            _cpp_object_equal("${an_obj}" result "${a_copy}")
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "derived_is_diff_instance")
        function("${derived_is_diff_instance}")
            ct_assert_not_equal(an_obj "${a_copy}")
        endfunction()

        ct_add_section(NAME "base_is_diff_instance")
        function("${base_is_diff_instance}")
            _cpp_object_get_meta_attr("${an_obj}" this_sub_objs "sub_objs")
            _cpp_object_get_meta_attr("${a_copy}" copy_sub_objs "sub_objs")
            cpp_map(GET "${this_sub_objs}" this_base "BaseClass")
            cpp_map(GET "${copy_sub_objs}" copy_base "BaseClass")
            ct_assert_not_equal(copy_base "${this_base}")
        endfunction()
    endfunction()
endfunction()
