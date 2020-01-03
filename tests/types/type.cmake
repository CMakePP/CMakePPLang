include(cmake_test/cmake_test)

ct_add_test("cpp_is_type")
    include(cmakepp_core/types/type)

    ct_add_section("Signature")
        cpp_is_type(return TRUE hello)
        ct_assert_fails_as("cpp_is_type takes exactly 2 arguments.")
    ct_end_section()

    ct_add_section("bool")
        cpp_is_type(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_type(return MyClass)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("command")
        cpp_is_type(return add_subdirectory)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o a type")
            cpp_is_type(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing a type")
            cpp_is_type(return "bool Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        cpp_is_type(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        cpp_is_type(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            cpp_is_type(return "hello;world")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List of types")
            cpp_is_type(return "int;bool")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_type(result a_map)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("obj")
        include(cmakepp_core/object/object)
        cpp_is_type(result "${__CPP_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("path")
        ct_add_section("Normal filepath (probably)")
            cpp_is_type(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Contains a type")
            cpp_is_type(return "${CMAKE_CURRENT_LIST_DIR}/int")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_is_type(return lib)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("type")

        ct_add_section("bool")
            cpp_is_type(return bool)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("class")
            cpp_is_type(return class)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("desc")
            cpp_is_type(return desc)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("float")
            cpp_is_type(return float)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("fxn")
            cpp_is_type(return fxn)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("genex")
            cpp_is_type(return genex)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("int")
            cpp_is_type(return int)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("list")
            cpp_is_type(return list)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("map")
            cpp_is_type(return map)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("obj")
            cpp_is_type(return obj)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("path")
            cpp_is_type(return path)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("str")
            cpp_is_type(return str)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("target")
            cpp_is_type(return target)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("type")
            cpp_is_type(return type)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

ct_end_test()
