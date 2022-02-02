include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# cpp_assert is supposed to crash the program if the provided condition is not
# true. When the condition is true this unit test basically just makes sure the
# program doesn't crash, when the condition is false it ensures that the
# program did error and it printed the required message.
#]]

ct_add_test(NAME "test_cpp_assert")
function("${test_cpp_assert}")
    include(cmakepp_lang/utilities/assert)

    ct_add_section(NAME "true_value")
    function("${true_value}")
        cpp_assert(TRUE "not printed")
    endfunction()

    ct_add_section(NAME "false_value" EXPECTFAIL)
    function("${false_value}")
        cpp_assert(FALSE "this is printed")
    endfunction()

    ct_add_section(NAME "condition")
    function("${condition}")
        ct_add_section(NAME "condition_true")
        function("${condition_true}")
            cpp_assert("x;STREQUAL;x" "not printed")
        endfunction()

        ct_add_section(NAME "condition_false" EXPECTFAIL)
        function("${condition_false}")
            cpp_assert("x;STREQUAL;y" "this is printed")
        endfunction()
    endfunction()
endfunction()
