include(cmake_test/cmake_test)

ct_add_test("_cpp_function_get_mangled_name")
    include(cmakepp_core/function/detail_/add_overload)
    include(cmakepp_core/function/detail_/get_mangled_name)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            _cpp_function_get_mangled_name(TRUE result)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_function_get_mangled_name(a_fxn TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("Overload does not exist")
        _cpp_function_get_mangled_name(a_fxn result 3 4)
        ct_assert_fails_as("a_fxn(int, int) does not exist")
    ct_end_section()

    ct_add_section("Overload is not in scope")
        _cpp_function_add_overload(a_fxn int int)
        _cpp_function_get_mangled_name(a_fxn result 3 4)
        ct_assert_fails_as("a_fxn(int, int) does not exist")
    ct_end_section()

    ct_add_section("No arguments")
        _cpp_function_add_overload(a_fxn)
        function(${a_fxn})
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("Purely variadic")
        _cpp_function_add_overload(a_fxn args)
        function(${a_fxn})
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result 1)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("One positional argument")
        _cpp_function_add_overload(a_fxn int)
        function(${a_fxn} arg0)
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result 3)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("Variadic with one positional argument")
        _cpp_function_add_overload(a_fxn int args)
        function(${a_fxn} arg0)
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result 3 2)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("Two positional arguments")
        _cpp_function_add_overload(a_fxn int bool)
        function(${a_fxn} arg0 arg1)
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result 3 TRUE)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("Variadic with two positional arguments")
        _cpp_function_add_overload(a_fxn int bool args)
        function(${a_fxn} arg0 arg1)
        endfunction()

        _cpp_function_get_mangled_name(a_fxn result 3 TRUE 2)
        ct_assert_equal(result "${a_fxn}")
    ct_end_section()

    ct_add_section("Two overloads exist")
        _cpp_function_add_overload(a_fxn int bool)
        function("${a_fxn}" arg0 arg1)
        endfunction()

        set(int_bool_mn "${a_fxn}")

        _cpp_function_add_overload(a_fxn)
        function("${a_fxn}")
        endfunction()

        set(void_mn "${a_fxn}")
        ct_add_section("Call a_fxn(int, bool)")
            _cpp_function_get_mangled_name(a_fxn result 3 TRUE)
            ct_assert_equal(result "${int_bool_mn}")
        ct_end_section()

        ct_add_section("Call a_fxn()")
            _cpp_function_get_mangled_name(a_fxn result)
            ct_assert_equal(result "${void_mn}")
        ct_end_section()
    ct_end_section()
ct_end_test()
