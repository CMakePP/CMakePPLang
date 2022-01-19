include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_type")
function("${test_cpp_is_type}")
    include(cmakepp_core/types/type)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        cpp_is_type(return TRUE hello)
    endfunction()

    ct_add_section(NAME "test_bool")
    function("${test_bool}")
        cpp_is_type(return TRUE)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_class")
    function("${test_class}")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_type(return MyClass)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_command")
    function("${test_command}")
        cpp_is_type(return add_subdirectory)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_descriptions")
    function("${test_descriptions}")
        ct_add_section(NAME "description_without_type")
        function("${description_without_type}")
            cpp_is_type(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description_contains_type")
        function("${description_contains_type}")
            cpp_is_type(return "bool Hello World")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_float")
    function("${test_float}")
        cpp_is_type(return 3.14)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_integer")
    function("${test_integer}")
        cpp_is_type(return 42)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_list")
    function("${test_list}")
        ct_add_section(NAME "normal_list")
        function("${normal_list}")
            cpp_is_type(return "hello;world")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "list_of_types")
        function("${list_of_types}")
            cpp_is_type(return "int;bool")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_map")
    function("${test_map}")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_type(result a_map)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_obj")
    function("${test_obj}")
        include(cmakepp_core/object/object)
        cpp_is_type(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_path")
    function("${test_path}")
        ct_add_section(NAME "normal_filepath")
        function("${normal_filepath}")
            cpp_is_type(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "contains_type")
        function("${contains_type}")
            cpp_is_type(return "${CMAKE_CURRENT_LIST_DIR}/int")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_target")
    function("${test_target}")
        add_library(lib STATIC IMPORTED)
        cpp_is_type(return lib)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_type")
    function("${test_type}")

        ct_add_section(NAME "test_type_bool")
        function("${test_type_bool}")
            cpp_is_type(return bool)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_class")
        function("${test_type_class}")
            cpp_is_type(return class)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_desc")
        function("${test_type_desc}")
            cpp_is_type(return desc)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_float")
        function("${test_type_float}")
            cpp_is_type(return float)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_fxn")
        function("${test_type_fxn}")
            cpp_is_type(return fxn)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_genex")
        function("${test_type_genex}")
            cpp_is_type(return genex)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_int")
        function("${test_type_int}")
            cpp_is_type(return int)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_list")
        function("${test_type_list}")
            cpp_is_type(return list)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_map")
        function("${test_type_map}")
            cpp_is_type(return map)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_obj")
        function("${test_type_obj}")
            cpp_is_type(return obj)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_path")
        function("${test_type_path}")
            cpp_is_type(return path)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_str")
        function("${test_type_str}")
            cpp_is_type(return str)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_target")
        function("${test_type_target}")
            cpp_is_type(return target)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "test_type_type")
        function("${test_type_type}")
            cpp_is_type(return type)
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

endfunction()
