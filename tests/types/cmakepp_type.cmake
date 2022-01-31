include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_get_cmakepp_type")
function("${test__cpp_get_cmakepp_type}")
    include(cmakepp_lang/map/map)
    include(cmakepp_lang/types/cmakepp_type)

    cpp_map(CTOR a_map)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        _cpp_get_cmakepp_type(is_obj type TRUE hello)
    endfunction()

    ct_add_section(NAME "get_type_cpp_obj")
    function("${get_type_cpp_obj}")

        _cpp_get_cmakepp_type(is_obj type "${a_map}")

        ct_add_section(NAME "id_cpp_obj")
        function("${id_cpp_obj}")
            ct_assert_equal(is_obj TRUE)
        endfunction()

        ct_add_section(NAME "id_type")
        function("${id_type}")
            ct_assert_equal(type map)
        endfunction()
    endfunction()

    ct_add_section(NAME "get_type_cmake_obj")
    function("${get_type_cmake_obj}")
        set(type bool)
        _cpp_get_cmakepp_type(is_obj type TRUE)

        ct_add_section(NAME "id_not_cpp_obj")
        function("${id_not_cpp_obj}")
            ct_assert_equal(is_obj FALSE)
        endfunction()

        ct_add_section(NAME "type_is_empty")
        function("${type_is_empty}")
            ct_assert_equal(type "")
        endfunction()
    endfunction()

    ct_add_section(NAME "is_case_insens")
    function("${is_case_insens}")

        string(TOUPPER "${a_map}" a_map)
        _cpp_get_cmakepp_type(is_obj type "${a_map}")

        ct_add_section(NAME "id_cpp_obj")
        function("${id_cpp_obj}")
            ct_assert_equal(is_obj TRUE)
        endfunction()

        ct_add_section(NAME "id_type")
        function("${id_type}")
            ct_assert_equal(type map)
        endfunction()
    endfunction()

endfunction()

ct_add_test(NAME "test__cpp_set_cmakepp_type")
function("${test__cpp_set_cmakepp_type}")
    include(cmakepp_lang/class/class)
    include(cmakepp_lang/types/cmakepp_type)

    cpp_class(MyClass)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        _cpp_set_cmakepp_type(an_obj MyClass hello)
    endfunction()

    ct_add_section(NAME "set_obj_type")
    function("${set_obj_type}")
        _cpp_set_cmakepp_type(an_obj MyClass)
        _cpp_get_cmakepp_type(is_obj type an_obj)
        ct_assert_equal(type MyClass)
    endfunction()
endfunction()
