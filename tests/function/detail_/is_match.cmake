include(cmake_test/cmake_test)

ct_add_test("_cpp_is_match")
    include(cmakepp_core/array/array)
    include(cmakepp_core/function/detail_/is_match)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        cpp_array(CTOR an_array)

        ct_add_section("Arg1 must be desc")
            _cpp_function_is_match(TRUE "${an_array}" "${an_array}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be array")
            _cpp_function_is_match(result TRUE "${an_array}")
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Arg3 must be array")
            _cpp_function_is_match(result "${an_array}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()

        ct_add_section("Takes 3 arguments")
            _cpp_function_is_match(result "${an_array}" "${an_array}" hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("non-variadic")
        cpp_array(CTOR sig int bool)

        ct_add_section("Is a match")
            cpp_array(CTOR types int bool)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Is not a match")
            cpp_array(CTOR types bool bool)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("purely variadic")
        cpp_array(CTOR sig args)

        ct_add_section("Matches 0 args")
            cpp_array(CTOR types)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Matches 1 arg")
            cpp_array(CTOR types int)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Matches 2 args")
            cpp_array(CTOR types bool int)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("position args and variadic")
        cpp_array(CTOR sig int bool args)

        ct_add_section("Match with 0 variadic args")
            cpp_array(CTOR types int bool)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Match with 1 variadic args")
            cpp_array(CTOR types int bool double)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Match with 2 variadic args")
            cpp_array(CTOR types int bool double path)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Not enough args")
            cpp_array(CTOR types int)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Incorrect positional args")
            cpp_array(CTOR types int int)
            _cpp_function_is_match(result "${sig}" "${types}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()
