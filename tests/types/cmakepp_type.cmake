include(cmake_test/cmake_test)

ct_add_test("_cpp_get_cmakepp_type")
    include(cmakepp_core/map/map)
    include(cmakepp_core/types/cmakepp_type)

    cpp_map(CTOR a_map)

    ct_add_section("Signature")
        _cpp_get_cmakepp_type(is_obj type TRUE hello)
        ct_assert_fails_as("_cpp_get_cmakepp_type takes exactly 3 arguments.")
    ct_end_section()

    ct_add_section("Get type of a CMakePP object")

        _cpp_get_cmakepp_type(is_obj type "${a_map}")

        ct_add_section("Correctly identified as CMakePP object")
            ct_assert_equal(is_obj TRUE)
        ct_end_section()

        ct_add_section("Correctly identifies type")
            ct_assert_equal(type map)
        ct_end_section()
    ct_end_section()

    ct_add_section("Get type of a CMake object")
        set(type bool)
        _cpp_get_cmakepp_type(is_obj type TRUE)

        ct_add_section("Correctly identified as not a CMakePP object")
            ct_assert_equal(is_obj FALSE)
        ct_end_section()

        ct_add_section("Sets type to empty string")
            ct_assert_equal(type "")
        ct_end_section()
    ct_end_section()

    ct_add_section("Is case-insensitive")

        string(TOUPPER "${a_map}" a_map)
        _cpp_get_cmakepp_type(is_obj type "${a_map}")

        ct_add_section("Correctly identified as CMakePP object")
            ct_assert_equal(is_obj TRUE)
        ct_end_section()

        ct_add_section("Correctly identifies type")
            ct_assert_equal(type map)
        ct_end_section()
    ct_end_section()

ct_end_test()

ct_add_test("_cpp_set_cmakepp_type")
    include(cmakepp_core/class/class)
    include(cmakepp_core/types/cmakepp_type)

    cpp_class(MyClass)

    ct_add_section("Signature")
        _cpp_set_cmakepp_type(an_obj MyClass hello)
        ct_assert_fails_as("_cpp_set_cmakepp_type takes exactly 2 arguments.")
    ct_end_section()

    ct_add_section("Can set an object's type")
        _cpp_set_cmakepp_type(an_obj MyClass)
        _cpp_get_cmakepp_type(is_obj type an_obj)
        ct_assert_equal(type MyClass)
    ct_end_section()
ct_end_test()
