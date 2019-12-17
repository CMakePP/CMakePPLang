include(cmake_test/cmake_test)

ct_add_test("cpp_overload_is_match")
    include(cmakepp_core/overload/overload)

    ct_add_section("No arguments")

        cpp_overload(CTOR an_overload a_fxn)

        ct_add_section("Is a match")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Not a match")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result FALSE)
        ct_end_section()

    ct_end_section()

    ct_add_section("Pure variadic")
        cpp_overload(CTOR an_overload a_fxn args)

        ct_add_section("Works with no arguments")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Works with 1 argument")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Works with 2 arguments")
            cpp_overload(IS_MATCH "${an_overload}" result int bool)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("1 positional argument")
        cpp_overload(CTOR an_overload a_fxn int)

        ct_add_section("Does not work without arguments")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with corect single argument")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Does not work with single argument is not convertible")
            cpp_overload(IS_MATCH "${an_overload}" result bool)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not works with 2 arguments")
            cpp_overload(IS_MATCH "${an_overload}" result int bool)
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Variadic with 1 positional argument")
        cpp_overload(CTOR an_overload a_fxn int args)

        ct_add_section("Does not work without arguments")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with 1 argument of the correct type")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Does not work with single argument of wrong type")
            cpp_overload(IS_MATCH "${an_overload}" result bool)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with 2 arguments")
            cpp_overload(IS_MATCH "${an_overload}" result int bool)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("2 positional arguments")
        cpp_overload(CTOR an_overload a_fxn int bool)

        ct_add_section("Does not work without arguments")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not work with a single argument")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with correct types")
            cpp_overload(IS_MATCH "${an_overload}" result int bool)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Does not work if first argument is wrong type")
            cpp_overload(IS_MATCH "${an_overload}" result bool bool)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not work if second argument is wrong type")
            cpp_overload(IS_MATCH "${an_overload}" result int int)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not work with three or more arguments")
            cpp_overload(IS_MATCH "${an_overload}" result int bool double)
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Variadic with 2 positional arguments")
        cpp_overload(CTOR an_overload a_fxn int bool args)

        ct_add_section("Does not work without arguments")
            cpp_overload(IS_MATCH "${an_overload}" result)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not work with a single argument")
            cpp_overload(IS_MATCH "${an_overload}" result int)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with correct types")
            cpp_overload(IS_MATCH "${an_overload}" result int bool)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Does not work if first argument is wrong type")
            cpp_overload(IS_MATCH "${an_overload}" result bool bool)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Does not work if second argument is wrong type")
            cpp_overload(IS_MATCH "${an_overload}" result int int)
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Works with 3 arguments if first two are right types")
            cpp_overload(IS_MATCH "${an_overload}" result int bool double)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()
