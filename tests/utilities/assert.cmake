include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# cpp_assert is supposed to crash the program if the provided condition is not
# true. When the condition is true this unit test basically just makes sure the
# program doesn't crash, when the condition is false it ensures that the
# program did error and it printed the required message.
#]]

ct_add_test("cpp_assert")
    include(cmakepp_core/utilities/assert)

    ct_add_section("true value")
        cpp_assert(TRUE "not printed")
    ct_end_section()

    ct_add_section("false value")
        cpp_assert(FALSE "this is printed")
        ct_assert_fails_as("Assertion: this is printed failed.")
    ct_end_section()

    ct_add_section("condition")
        ct_add_section("condition is true")
            cpp_assert("x;STREQUAL;x" "not printed")
        ct_end_section()

        ct_add_section("condition is false")
            cpp_assert("x;STREQUAL;y" "this is printed")
            ct_assert_fails_as("Assertion: this is printed failed.")
        ct_end_section()
    ct_end_section()
ct_end_test()



