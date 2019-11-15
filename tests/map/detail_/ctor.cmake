include(cmake_test/cmake_test)

ct_add_test("_cpp_map_mangle")
    include(cmakepp_core/map/detail_/ctor)

    ct_add_section("empty this ptr")
        _cpp_map_mangle(result)
        ct_assert_equal(result "__cpp_map_")
    ct_end_section()

    ct_add_section("Non-empty this ptr")
        set(result x)
        _cpp_map_mangle(prefix)
        _cpp_map_mangle(result)
        ct_assert_equal(result "${prefix}x")
    ct_end_section()
ct_end_test()

ct_add_test("_cpp_map_ctor")
    include(cmakepp_core/map/detail_/ctor)

    _cpp_map_ctor(my_map)
    get_property(result GLOBAL PROPERTY ${my_map}_keys DEFINED)
    ct_assert_equal(result 1)
ct_end_test()
