include(cmake_test/cmake_test)

ct_add_test("_cpp_function_add_overload")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/function/detail_/add_overload)


    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        _cpp_function_add_overload(TRUE)
        ct_assert_fails_as("Assertion: TRUE is desc")
    ct_end_section()

    cpp_array(CTOR sig0 int bool)
    _cpp_mangle_fxn(mn0 a_fxn int bool)

    ct_add_section("No previous overloads")
        _cpp_function_add_overload(a_fxn int bool)

        ct_add_section("Returns mangled name")
            ct_assert_equal(a_fxn "${mn0}")
        ct_end_section()

        ct_add_section("Correctly sets value")
            _cpp_function_get_overloads(a_fxn overloads)
            cpp_map(CTOR corr "${sig0}" "${mn0}")
            include(cmakepp_core/utilities/print_objects)
            cpp_print_objects("${corr}" "${overloads}")
            cpp_equal(result "${corr}" "${overloads}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Previous overloads")
        _cpp_function_add_overload(a_fxn int bool)
        function("${a_fxn}")
        endfunction()

        ct_add_section("Add a good overload")
            _cpp_function_add_overload(a_fxn int int)
            _cpp_mangle_fxn(mn1 a_fxn int int)

            ct_add_section("Returns mangled name")
                ct_assert_equal(a_fxn "${mn1}")
            ct_end_section()

            ct_add_section("Correctly sets value")
                cpp_array(CTOR sig1 int int)
                cpp_map(CTOR corr "${sig0}" "${mn0}" "${sig1}" "${mn1}")
                _cpp_function_get_overloads(a_fxn overloads)
                cpp_equal(result "${corr}" "${overloads}")
            ct_end_section()
        ct_end_section()

        ct_add_section("Add a bad overload")
            set(CMAKEPP_CORE_DEBUG_MODE ON)

            ct_add_section("Same signature")
                _cpp_function_add_overload(a_fxn int bool)
                ct_assert_fails_as("a_fxn(int, bool) conflicts with")
            ct_end_section()

            ct_add_section("Variadic conflict")
                _cpp_function_add_overload(a_fxn int args)
                ct_assert_fails_as("a_fxn(int, args) conflicts with")
            ct_end_section()
        ct_end_section()
    ct_end_section()
ct_end_test()
