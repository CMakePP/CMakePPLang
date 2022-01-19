include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_type_of")
function("${test_cpp_type_of}")
    include(cmakepp_core/types/type_of)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        cpp_type_of(result TRUE hello)
    endfunction()

    ct_add_section(NAME "test_bool")
    function("${test_bool}")
        cpp_type_of(return TRUE)
        ct_assert_equal(return bool)
    endfunction()

    ct_add_section(NAME "test_class")
    function("${test_class}")
        include(cmakepp_core/class/class)
        cpp_class(a_class)
        cpp_type_of(return a_class)
        ct_assert_equal(return class)
    endfunction()

    ct_add_section(NAME "test_command")
    function("${test_command}")
        cpp_type_of(return add_subdirectory)
        ct_assert_equal(return fxn)
    endfunction()

    ct_add_section(NAME "test_desc")
    function("${test_desc}")
        cpp_type_of(return "hello world")
        ct_assert_equal(return desc)
    endfunction()

    ct_add_section(NAME "empty_string")
    function("${empty_string}")
        cpp_type_of(return "")
        ct_assert_equal(return desc)
    endfunction()

    ct_add_section(NAME "test_float")
    function("${test_float}")
        cpp_type_of(return 3.14)
        ct_assert_equal(return float)
    endfunction()

    ct_add_section(NAME "test_int")
    function("${test_int}")
        cpp_type_of(return 42)
        ct_assert_equal(return int)
    endfunction()

    ct_add_section(NAME "test_list")
    function("${test_list}")
        cpp_type_of(return [[hello;world]])
        ct_assert_equal(return list)
    endfunction()

    ct_add_section(NAME "test_map")
    function("${test_map}")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_type_of(result "${a_map}")
        ct_assert_equal(result map)
    endfunction()

    ct_add_section(NAME "test_obj")
    function("${test_obj}")
        include(cmakepp_core/class/class)

        ct_add_section(NAME "obj_instance")
        function("${obj_instance}")
            cpp_type_of(return "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
            ct_assert_equal(return obj)
        endfunction()

        ct_add_section(NAME "user_defined_obj")
        function("${user_defined_obj}")
            cpp_class(MyClass)
            myclass(CTOR obj)
            cpp_type_of(return "${obj}")
            ct_assert_equal(return myclass)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_path")
    function("${test_path}")
        cpp_type_of(return "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(return path)
    endfunction()

    ct_add_section(NAME "test_target")
    function("${test_target}")
        add_library(lib STATIC IMPORTED)
        cpp_type_of(return lib)
        ct_assert_equal(return target)
    endfunction()

    ct_add_section(NAME "test_type")
    function("${test_type}")
        cpp_type_of(return bool)
        ct_assert_equal(return type)
    endfunction()

endfunction()
