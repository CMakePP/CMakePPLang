include(cmake_test/cmake_test)

ct_add_test("cpp_member")
    include(cmakepp_core/class/class)

    cpp_class(MyNewClass)

    ct_add_section("Member function with no arguments")
        cpp_member(no_args MyNewClass)

        ct_add_section("Mangled signature")
            ct_assert_equal(no_args "no_args_mynewclass")
        ct_end_section()
    ct_end_section()
ct_end_test()
