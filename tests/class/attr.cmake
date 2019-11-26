include(cmake_test/cmake_test)

ct_add_test("cpp_member")
    include(cmakepp_core/class/class)

    cpp_class(MyNewClass)

    ct_add_section("Attribute")
        cpp_attr(MyNewClass attr desc)

        ct_add_section("Correctly registers the attribute")
            _cpp_class_get_attrs(attrs MyNewClass)
            cpp_map(CTOR corr attr desc)
            cpp_equal(result "${corr}" "${attrs}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

ct_end_test()
