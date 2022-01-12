include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_list")
function("${test_cpp_is_list}")
    include(cmakepp_core/types/list)

    ct_add_section(NAME "Signature")
        cpp_is_list(return TRUE hello)
        ct_assert_fails_as("cpp_is_list takes exactly 2 arguments.")
    endfunction()

    ct_add_section(NAME "bool")
        cpp_is_list(return TRUE)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_list(return MyClass)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "command")
        cpp_is_list(return add_subdirectory)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "descriptions")

        ct_add_section(NAME "description w/o a list")
            cpp_is_list(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description containing escaped semicolons")
            cpp_is_list(return "Hello World 1\\\;2\\\;3")
            ct_assert_equal(return FALSE)
        endfunction()

    endfunction()

    ct_add_section(NAME "float")
        cpp_is_list(return 3.14)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "integer")
        cpp_is_list(return 42)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "list")
        ct_add_section(NAME "Normal list")
            cpp_is_list(return "1;2;3")
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "List of lists")
            cpp_is_list(return "TRUE\\\;FALSE;FALSE\\\;TRUE")
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_list(result a_map)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "obj")
        include(cmakepp_core/object/object)
        cpp_is_list(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "path")
        ct_add_section(NAME "Normal filepath (probably)")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "Contains a semicolon (please don't do this either)")
            cpp_is_list(return "${CMAKE_CURRENT_LIST_DIR}/hello\\\;world")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "target")
        add_library(lib STATIC IMPORTED)
        cpp_is_list(return lib)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "type")
        cpp_is_list(return bool)
        ct_assert_equal(return FALSE)
    endfunction()
endfunction()
