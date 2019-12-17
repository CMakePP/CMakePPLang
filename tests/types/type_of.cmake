include(cmake_test/cmake_test)

ct_add_test("cpp_type_of")
    include(cmakepp_core/types/type_of)

    ct_add_section("bool")
        cpp_type_of(return TRUE)
        ct_assert_equal(return bool)
    ct_end_section()

    ct_add_section("class")
        include(cmakepp_core/class/ctor)
        cpp_class_ctor(a_class)
        cpp_type_of(return "${a_class}")
        ct_assert_equal(return class)
    ct_end_section()

    ct_add_section("desc")
        cpp_type_of(return "hello world")
        ct_assert_equal(return desc)
    ct_end_section()

    ct_add_section("empty string")
        cpp_type_of(return "")
        ct_assert_equal(return desc)
    ct_end_section()

    ct_add_section("float")
        cpp_type_of(return 3.14)
        ct_assert_equal(return float)
    ct_end_section()

    ct_add_section("int")
        cpp_type_of(return 42)
        ct_assert_equal(return int)
    ct_end_section()

    ct_add_section("list")
        cpp_type_of(return [[hello;world]])
        ct_assert_equal(return list)
    ct_end_section()

#    ct_add_section("obj")
#        cpp_type_of(return obj)
#        ct_assert_equal(return TRUE)
#    ct_end_section()

    ct_add_section("path")
        cpp_type_of(return "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(return path)
    ct_end_section()

    ct_add_section("target")
        add_library(lib STATIC IMPORTED)
        cpp_type_of(return lib)
        ct_assert_equal(return target)
    ct_end_section()

    ct_add_section("type")
        cpp_type_of(return bool)
        ct_assert_equal(return type)
    ct_end_section()

ct_end_test()
