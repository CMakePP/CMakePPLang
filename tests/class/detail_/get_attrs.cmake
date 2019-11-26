include(cmake_test/cmake_test)

ct_add_test("_cpp_class_get_attrs")
    include(cmakepp_core/class/class)
    include(cmakepp_core/class/detail_/get_attrs)

    cpp_class(MyClass)

    ct_add_section("Class with no attributes")
        _cpp_class_get_attrs(attrs MyClass)
        cpp_map(CTOR corr)
        cpp_equal(result "${corr}" "${attrs}")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()
