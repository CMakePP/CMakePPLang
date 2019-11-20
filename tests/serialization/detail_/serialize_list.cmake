include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_list")
    include(cmakepp_core/serialization/detail_/serialize_list)

    ct_add_section("empty list")
        _cpp_serialize_list(result "")
        ct_assert_equal(result "[ ]")
    ct_end_section()

    ct_add_section("one-item list")
        _cpp_serialize_list(result "hello")
        ct_assert_equal(result "[ \"hello\" ]")
    ct_end_section()

    ct_add_section("two-item list")
        _cpp_serialize_list(result "hello;world")
        ct_assert_equal(result "[ \"hello\" , \"world\" ]")
    ct_end_section()

    ct_add_section("List with a map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        _cpp_serialize_list(result "hello;${a_map}")
        ct_assert_equal(result "[ \"hello\" , { } ]")
    ct_end_section()

ct_end_test()
