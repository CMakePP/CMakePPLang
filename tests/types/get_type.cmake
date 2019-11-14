include(cmake_test/cmake_test)

ct_add_test("cpp_get_type")
    include(cmakepp_core/types/get_type)

    ct_add_section("bool")
        cpp_get_type(return TRUE)
        ct_assert_equal(return "bool")
    ct_end_section()

    ct_add_section("description")
        cpp_get_type(return "Hello World")
        ct_assert_equal(return "desc")
    ct_end_section()

    ct_add_section("filepath")
        cpp_get_type(return "${CMAKE_BINARY_DIR}")
        ct_assert_equal(return "path")
    ct_end_section()

    ct_add_section("float")
        cpp_get_type(return 3.14)
        ct_assert_equal(return "float")
    ct_end_section()

    ct_add_section("int")
        cpp_get_type(return 42)
        ct_assert_equal(return "int")
    ct_end_section()

    ct_add_section("list")
        cpp_get_type(return "1;2;3")
        ct_assert_equal(return "list")
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/ctor)
        _cpp_map_ctor(my_map)
        cpp_get_type(result "${my_map}")
        ct_assert_equal(result "map")
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_get_type(return lib)
        ct_assert_equal(return "target")
    ct_end_section()

    ct_add_section("type")
        cpp_get_type(return bool)
        ct_assert_equal(return "type")
    ct_end_section()
ct_end_test()
