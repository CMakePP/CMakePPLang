include(cmake_test/cmake_test)

ct_add_test("_cpp_object_get_fxns")
    include(cmakepp_core/object/detail_/ctor)
    include(cmakepp_core/object/detail_/get_fxns)

    _cpp_object_ctor(an_object)

    ct_add_section("Default object")
        include(cmakepp_core/algorithm/equal)
        cpp_map(CTOR corr)
        _cpp_object_get_fxns(fxns "${an_object}")
        cpp_equal(result "${corr}" "${fxns}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
