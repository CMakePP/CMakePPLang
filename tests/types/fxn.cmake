include(cmake_test/cmake_test)

ct_add_test("cpp_is_fxn")
    include(cmakepp_core/types/fxn)

    ct_add_section("Signature")
        cpp_is_fxn(return add_subdirectory hello)
        ct_assert_fails_as("cpp_is_fxn accepts exactly 2 arguments")
    ct_end_section()

    ct_add_section("bool")
        cpp_is_fxn(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_fxn(return MyClass)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("command")
        cpp_is_fxn(return add_subdirectory)
        ct_assert_equal(return TRUE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o a fxn")
            cpp_is_fxn(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing a fxn")
            cpp_is_fxn(return "Hello World add_subdirectory")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        cpp_is_fxn(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_fxn(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            cpp_is_fxn(return [[hello;world]])
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List of fxns")
            cpp_is_fxn(return [[add_subdirectory;include]])
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_fxn(result a_map)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("obj")
        include(cmakepp_core/object/object)
        cpp_is_fxn(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("path")
        ct_add_section("Normal path")
            cpp_is_fxn(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Path with fxn in it")
            cpp_is_fxn(return "${CMAKE_CURRENT_LIST_DIR}/add_subdirectory")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target")
        ct_add_section("normal target name")
            add_library(lib STATIC IMPORTED)
            cpp_is_fxn(return lib)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("target with fxn")
            add_library(libadd_subdirectory STATIC IMPORTED)
            cpp_is_fxn(return lib1)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("type")

        ct_add_section("type that is not also a command")
            cpp_is_fxn(return bool)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("list (which is also a command)")
            cpp_is_fxn(return list)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()