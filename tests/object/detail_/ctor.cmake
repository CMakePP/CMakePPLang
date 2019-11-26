include(cmake_test/cmake_test)

ct_add_test("_cpp_object_ctor")
    include(cmakepp_core/object/detail_/ctor)

    ct_add_section("initial state")
        _cpp_object_ctor(an_object)
        include(cmakepp_core/algorithm/equal)
        cpp_map(CTOR fxns)
        cpp_map(CTOR attrs)
        cpp_array(CTOR bases object)
        cpp_map(CTOR corr attrs "${attrs}"
                          fxns  "${fxns}"
                          src_file "${CMAKE_CURRENT_LIST_DIR}"
                          types "${bases}"
        )
        cpp_equal(result "${corr}" "${an_object}")
        ct_assert_equal(result TRUE)
    ct_end_section()
ct_end_test()
