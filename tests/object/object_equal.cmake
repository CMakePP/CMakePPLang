include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_equal")
function("${test__cpp_object_equal}")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_equal(TRUE result "${an_obj}")
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_equal("${an_obj}" TRUE "${an_obj}")
        endfunction()

        ct_add_section(NAME "third_arg_obj" EXPECTFAIL)
        function("${third_arg_obj}")
            _cpp_object_equal("${an_obj}" result TRUE)
        endfunction()

        ct_add_section(NAME "takes_three_args" EXPECTFAIL)
        function("${takes_three_args}")
            _cpp_object_equal("${an_obj}" result "${an_obj}" hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "equal_objects")
    function("${equal_objects}")
        _cpp_object_equal("${an_obj}" result "${an_obj}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME "diff_objects")
    function("${diff_objects}")
        _cpp_object_equal(
            "${an_obj}" result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}"
        )
        ct_assert_equal(result FALSE)
    endfunction()
endfunction()
