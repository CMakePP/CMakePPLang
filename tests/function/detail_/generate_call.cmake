include(cmake_test/cmake_test)

ct_add_test("_cpp_generate_call")
    include(cmakepp_core/algorithm/equal)
    include(cmakepp_core/function/detail_/generate_call)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Argument 1 must be desc")
            _cpp_generate_call(TRUE result)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Argument 2 must be desc")
            _cpp_generate_call(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("No args")
        _cpp_generate_call(result a_fxn)
        set(corr [[a_fxn()]])
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()

    ct_add_section("Only *args")
        _cpp_generate_call(result a_fxn args)
        set(corr [[a_fxn( ${ARGN})]])
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()

    ct_add_section("One arg")
        _cpp_generate_call(result a_fxn int)
        set(corr [[a_fxn( "${__cpp_fxn_arg_0__}")]])
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()

    ct_add_section("One arg and *args")
        _cpp_generate_call(result a_fxn int args)
        set(corr [[a_fxn( "${__cpp_fxn_arg_0__}" ${ARGN})]])
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()

    ct_add_section("Two args")
        _cpp_generate_call(result a_fxn int bool)
        set(
            corr [[a_fxn( "${__cpp_fxn_arg_0__}" "${__cpp_fxn_arg_1__}")]]
        )
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()

    ct_add_section("Two args and *args")
        _cpp_generate_call(result a_fxn int bool args)
        set(
            corr
            [[a_fxn( "${__cpp_fxn_arg_0__}" "${__cpp_fxn_arg_1__}" ${ARGN})]]
        )
        cpp_equal(test_passed "${corr}" "${result}")
        ct_assert_equal(test_passed TRUE)
    ct_end_section()
ct_end_test()
