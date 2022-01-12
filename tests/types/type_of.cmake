include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_type_of")
function("${test_cpp_type_of}")
    include(cmakepp_core/types/type_of)

    ct_add_section(NAME "Signature")
        cpp_type_of(result TRUE hello)
        ct_assert_fails_as("cpp_type_of takes exactly 2 arguments.")
    endfunction()

    ct_add_section(NAME "bool")
        cpp_type_of(return TRUE)
        ct_assert_equal(return bool)
    endfunction()

    ct_add_section(NAME "class")
        include(cmakepp_core/class/class)
        cpp_class(a_class)
        cpp_type_of(return a_class)
        ct_assert_equal(return class)
    endfunction()

    ct_add_section(NAME "command")
        cpp_type_of(return add_subdirectory)
        ct_assert_equal(return fxn)
    endfunction()

    ct_add_section(NAME "desc")
        cpp_type_of(return "hello world")
        ct_assert_equal(return desc)
    endfunction()

    ct_add_section(NAME "empty string")
        cpp_type_of(return "")
        ct_assert_equal(return desc)
    endfunction()

    ct_add_section(NAME "float")
        cpp_type_of(return 3.14)
        ct_assert_equal(return float)
    endfunction()

    ct_add_section(NAME "int")
        cpp_type_of(return 42)
        ct_assert_equal(return int)
    endfunction()

    ct_add_section(NAME "list")
        cpp_type_of(return [[hello;world]])
        ct_assert_equal(return list)
    endfunction()

    ct_add_section(NAME "map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_type_of(result "${a_map}")
        ct_assert_equal(result map)
    endfunction()

    ct_add_section(NAME "obj")
        include(cmakepp_core/class/class)

        ct_add_section(NAME "An actual Object instance")
            cpp_type_of(return "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
            ct_assert_equal(return obj)
        endfunction()

        ct_add_section(NAME "An instance of a user-defined class")
            cpp_class(MyClass)
            myclass(CTOR obj)
            cpp_type_of(return "${obj}")
            ct_assert_equal(return myclass)
        endfunction()
    endfunction()

    ct_add_section(NAME "path")
        cpp_type_of(return "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(return path)
    endfunction()

    ct_add_section(NAME "target")
        add_library(lib STATIC IMPORTED)
        cpp_type_of(return lib)
        ct_assert_equal(return target)
    endfunction()

    ct_add_section(NAME "type")
        cpp_type_of(return bool)
        ct_assert_equal(return type)
    endfunction()

endfunction()
