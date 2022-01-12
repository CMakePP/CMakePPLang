include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_target")
function("${test_cpp_is_target}")
    include(cmakepp_core/types/target)

    ct_add_section(NAME "Signature")
        cpp_is_target(return TRUE hello)
        ct_assert_fails_as("cpp_is_target takes exactly 2 arguments.")
    endfunction()

    ct_add_section(NAME "bool")
        cpp_is_target(return TRUE)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_target(return MyClass)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "command")
        cpp_is_target(return add_subdirectory)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "descriptions")
        ct_add_section(NAME "description w/o a target")
            cpp_is_target(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description containing a target")
            add_library(lib STATIC IMPORTED)
            cpp_is_target(return "lib Hello World")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "float")
        cpp_is_target(return 3.14)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "integer")
        cpp_is_target(return 42)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "list")
        ct_add_section(NAME "Normal list")
            cpp_is_target(return "hello;world")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "List of targets")
            add_library(lib1 STATIC IMPORTED)
            add_library(lib2 STATIC IMPORTED)
            cpp_is_target(return "lib1;lib2")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_target(result a_map)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "obj")
        include(cmakepp_core/object/object)
        cpp_is_target(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "path")
        ct_add_section(NAME "Normal filepath (probably)")
            cpp_is_target(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "Contains a target")
            add_library(lib STATIC IMPORTED)
            cpp_is_target(return "${CMAKE_CURRENT_LIST_DIR}/lib")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "target")
        add_library(lib STATIC IMPORTED)
        cpp_is_target(return lib)
        ct_assert_equal(return TRUE)
    endfunction()

    ct_add_section(NAME "type")
        cpp_is_target(return bool)
        ct_assert_equal(return FALSE)
    endfunction()
endfunction()
