include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_list")
function("${test_cpp_is_list}")
    include(cmakepp_lang/types/list)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        cpp_is_list(return TRUE hello)
    endfunction()

    ct_add_section(NAME "test_bool")
    function("${test_bool}")
        cpp_is_list(return TRUE)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_class")
    function("${test_class}")
        include(cmakepp_lang/class/class)
        cpp_class(MyClass)

        cpp_is_list(return MyClass)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_command")
    function("${test_command}")
        cpp_is_list(return add_subdirectory)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_descriptions")
    function("${test_descriptions}")

        ct_add_section(NAME "description_without_list")
        function("${description_without_list}")
            cpp_is_list(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description_escaped_semicolons")
        function("${description_escaped_semicolons}")
            cpp_is_list(return "Hello World 1\\\;2\\\;3")
            ct_assert_equal(return FALSE)
        endfunction()

    endfunction()

    ct_add_section(NAME "test_float")
    function("${test_float}")
        cpp_is_list(return 3.14)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_integer")
    function("${test_integer}")
        cpp_is_list(return 42)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_list")
    function("${test_list}")
        ct_add_section(NAME "normal_list")
        function("${normal_list}")
            cpp_is_list(return "1;2;3")
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "list_of_lists")
        function("${list_of_lists}")
            cpp_is_list(return "TRUE\\\;FALSE;FALSE\\\;TRUE")
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_map")
    function("${test_map}")
        include(cmakepp_lang/map/map)
        cpp_map(CTOR a_map)
        cpp_is_list(result a_map)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_obj")
    function("${test_obj}")
        include(cmakepp_lang/object/object)
        cpp_is_list(result "${__cmakepp_lang_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_path")
    function("${test_path}")
        ct_add_section(NAME "normal_filepath")
        function("${normal_filepath}")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "path_contains_semicolon")
        function("${path_contains_semicolon}")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}/hello\\\;world")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_target")
    function("${test_target}")
        add_library(lib STATIC IMPORTED)
        cpp_is_list(return lib)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_type")
    function("${test_type}")
        cpp_is_list(return bool)
        ct_assert_equal(return FALSE)
    endfunction()
endfunction()
