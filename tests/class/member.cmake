include(cmake_test/cmake_test)

ct_add_test("cpp_member")
    include(cmakepp_core/class/class)

    cpp_class(MyNewClass)

    ct_add_section("Member function with no arguments")
        cpp_member(no_args MyNewClass)

        ct_add_section("Returns Mangled signature")
            _cpp_mangle_fxn(corr no_args MyNewClass)
            ct_assert_equal(no_args "${corr}")
        ct_end_section()

        ct_add_section("Correctly registers the overload")
            _cpp_class_get_overloads(overloads MyNewClass no_args)
            cpp_array(CTOR corr "${no_args}")
            cpp_equal(result "${corr}" "${overloads}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Member function with one argument")
        cpp_member(one_arg MyNewClass int)

        ct_add_section("Returns Mangled signature")
            _cpp_mangle_fxn(corr one_arg MyNewClass int)
            ct_assert_equal(one_arg "${corr}")
        ct_end_section()

        ct_add_section("Correctly registers the overload")
            _cpp_class_get_overloads(overloads MyNewClass one_arg)
            cpp_array(CTOR corr "${one_arg}")
            cpp_equal(result "${corr}" "${overloads}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Member function with two arguments")
        cpp_member(two_args MyNewClass int bool)

        ct_add_section("Returns Mangled signature")
            _cpp_mangle_fxn(corr two_args MyNewClass int bool)
            ct_assert_equal(two_args "${corr}")
        ct_end_section()

        ct_add_section("Correctly registers the overload")
            _cpp_class_get_overloads(overloads MyNewClass two_args)
            cpp_array(CTOR corr "${two_args}")
            cpp_equal(result "${corr}" "${overloads}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Calling twice adds an overload")
        cpp_member(two_args MyNewClass int bool)
        set(mangle1 "${two_args}")
        cpp_member(two_args MyNewClass bool bool)

        _cpp_class_get_overloads(overloads MyNewClass two_args)
        cpp_array(CTOR corr "${mangle1}" "${two_args}")
        cpp_equal(result "${corr}" "${overloads}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Cannot add the same overload twice")
        cpp_member(two_args MyNewClass int bool)
        cpp_member(two_args MyNewClass int bool)
        ct_assert_fails_as("Assertion: two_args(int, bool) does not exist")
    ct_end_section()
ct_end_test()
