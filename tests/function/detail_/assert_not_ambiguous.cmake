include(cmake_test/cmake_test)

ct_add_test("_cpp_function_assert_not_ambiguous")
    include(cmakepp_core/function/detail_/add_overload)
    include(cmakepp_core/function/detail_/assert_not_ambiguous)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("Signature")
        _cpp_function_assert_not_ambiguous(TRUE)
        ct_assert_fails_as("Assertion: TRUE is desc")
    ct_end_section()

    ct_add_section("Add non-variadic overload")
        ct_add_section("Overload does not exist")
            _cpp_function_assert_not_ambiguous(a_fxn int bool)
        ct_end_section()

        ct_add_section("Fails if overload exists and is in scope")
            _cpp_function_add_overload(a_fxn int bool)
            function("${a_fxn}")
            endfunction()
            _cpp_function_assert_not_ambiguous(a_fxn int bool)
            ct_assert_fails_as("a_fxn(int, bool) conflicts with")
        ct_end_section()

        ct_add_section("Fails if existing variadic overload with less args")
            _cpp_function_add_overload(a_fxn int args)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool)
            ct_assert_fails_as("a_fxn(int, bool) conflicts with")
        ct_end_section()

        ct_add_section("Fails if existing variadic overload with same args")
            _cpp_function_add_overload(a_fxn int bool args)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool)
            ct_assert_fails_as("a_fxn(int, bool) conflicts with")
        ct_end_section()
    ct_end_section()

    ct_add_section("Adding variadic overload")
        ct_add_section("Overload does not exist")
            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
        ct_end_section()

        ct_add_section("Already exists")
            _cpp_function_add_overload(a_fxn int bool args)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
            ct_assert_fails_as("a_fxn(int, bool, args) conflicts with")
        ct_end_section()

        ct_add_section("Existing overload with same positional args")
            _cpp_function_add_overload(a_fxn int bool)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
            ct_assert_fails_as("a_fxn(int, bool, args) conflicts with")
        ct_end_section()

        ct_add_section("Existing overload with more positional args")
            _cpp_function_add_overload(a_fxn int bool path)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
            ct_assert_fails_as("a_fxn(int, bool, args) conflicts with")
        ct_end_section()

        ct_add_section("Existing variadic overload with less positional args")
            _cpp_function_add_overload(a_fxn int args)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
            ct_assert_fails_as("a_fxn(int, bool, args) conflicts with")
        ct_end_section()

        ct_add_section("Existing variadic overload with more positional args")
            _cpp_function_add_overload(a_fxn int bool path args)
            function("${a_fxn}")
            endfunction()

            _cpp_function_assert_not_ambiguous(a_fxn int bool args)
            ct_assert_fails_as("a_fxn(int, bool, args) conflicts with")
        ct_end_section()
    ct_end_section()

    ct_add_section("Does not fail if overload exists, but is not in scope")
        _cpp_function_add_overload(a_fxn int bool)
        _cpp_function_assert_not_ambiguous(a_fxn int bool)
    ct_end_section()
ct_end_test()
