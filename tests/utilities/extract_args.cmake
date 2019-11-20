include(cmake_test/cmake_test)

ct_add_test("cpp_extract_args")
    include(cmakepp_core/array/array)
    include(cmakepp_core/utilities/extract_args)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: desc")
            cpp_array(CTOR the_string)
            cpp_extract_args(TRUE "${the_string}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: array")
            cpp_extract_args(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is array")
        ct_end_section()
    ct_end_section()

    ct_add_section("all on one line")
        cpp_array(
            CTOR the_string
            "a_fxn(arg1 arg2 arg3)" "contents_of_fxn" "end_a_fxn()"
        )
        cpp_extract_args(result "${the_string}")
        cpp_array(GET e0 "${result}" 0)
        ct_assert_equal(e0 arg1)
        cpp_array(GET e1 "${result}" 1)
        ct_assert_equal(e1 arg2)
        cpp_array(GET e2 "${result}" 2)
        ct_assert_equal(e2 arg3)
    ct_end_section()

    ct_add_section("On two lines")
        cpp_array(
            CTOR the_string
                "a_fxn(arg1 arg2" "arg3)" "contents_of_fxn" "end_a_fxn()"
        )
        cpp_extract_args(result "${the_string}")
        cpp_array(GET e0 "${result}" 0)
        ct_assert_equal(e0 arg1)
        cpp_array(GET e1 "${result}" 1)
        ct_assert_equal(e1 arg2)
        cpp_array(GET e2 "${result}" 2)
        ct_assert_equal(e2 arg3)
    ct_end_section()

    ct_add_section("On three lines")
        cpp_array(
            CTOR the_string
            "a_fxn(arg1" "arg2" "arg3)" "contents_of_fxn" "end_a_fxn()"
        )
        cpp_extract_args(result "${the_string}")
        cpp_array(GET e0 "${result}" 0)
        ct_assert_equal(e0 arg1)
        cpp_array(GET e1 "${result}" 1)
        ct_assert_equal(e1 arg2)
        cpp_array(GET e2 "${result}" 2)
        ct_assert_equal(e2 arg3)
    ct_end_section()

    ct_add_section("Fails if nested parentheses")
        cpp_array(CTOR the_string [[a_fxn(\\\\(]])
        cpp_extract_args(result "${the_string}")
        ct_assert_fails_as("cpp_extract_args does not support parsing")
    ct_end_section()

    ct_add_section("Fails if left ( is not found")
        cpp_array(CTOR the_string "a_fxn")
        cpp_extract_args(result "${the_string}")
        ct_assert_fails_as("Did not find anything of the form (...)")
    ct_end_section()

    ct_add_section("Fails if right ) is not found")
        cpp_array(CTOR the_string "a_fxn(")
        cpp_extract_args(result "${the_string}")
        ct_assert_fails_as("Never found the matching ')'")
    ct_end_section()
ct_end_test()
