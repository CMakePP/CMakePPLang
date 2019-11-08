include(cmake_test/cmake_test)

ct_add_test("ternary_op")
    include(cmakepp_core/utilities/ternary_op)
    ct_add_section("true branch")
        set(input "foo")
        cpp_ternary_op(result "was_true" "was_false" "${input}" STREQUAL "foo")
        ct_assert_equal(result "was_true")
    ct_end_section()

    ct_add_section("false branch")
        cpp_ternary_op(result "was_true" "was_false" "foo" STREQUAL "bar")
        ct_assert_equal(result "was_false")
    ct_end_section()

    ct_add_section("conditions with empty string")
        cpp_ternary_op(result "was_true" "was_false" "" STREQUAL "bar")
        ct_assert_equal(result "was_false")

        cpp_ternary_op(result "was_true" "was_false" "" STREQUAL "")
        ct_assert_equal(result "was_true")
    ct_end_section()

    ct_add_section("raises syntax error")
        cpp_ternary_op(result "was_true" "was_false")
        ct_assert_fails_as("Ternary op")
    ct_end_section()
ct_end_test()
