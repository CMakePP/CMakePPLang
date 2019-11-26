include(cmake_test/cmake_test)

ct_add_test("_cpp_map_copy")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/map/map)

    cpp_map(CTOR a_map "hello" "world" "foo" "bar")
    _cpp_map_copy(a_copy "${a_map}")

    ct_add_section("Different instances")
        if("${a_copy}" STREQUAL "${a_map}")
            message(FATAL_ERROR "Maps have same this pointer")
        endif()
    ct_end_section()

    ct_add_section("Initially equal")
        cpp_equal(result "${a_copy}" "${a_map}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Are decoupled")
        cpp_map(SET "${a_copy}" foo 42)
        cpp_equal(result "${a_copy}" "${a_map}")
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
