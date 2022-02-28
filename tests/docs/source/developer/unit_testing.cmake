include(cmake_test/cmake_test)

include(cmakepp_lang/asserts/signature)

function(my_function arg0 arg1)
    cpp_assert_signature("${ARGV}" desc bool)
    # Function implementation goes here
endfunction()

ct_add_test(NAME "test_my_function")
function("${test_my_function}")
    # Uncomment and include your function module file
    # include(path/to/my_function/implementation)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        # Enable debug mode so type checking occurs in this section
        set(CMAKEPP_LANG_DEBUG_MODE TRUE)

        ct_add_section(NAME "first_argument_must_be_a_desc" EXPECTFAIL)
        function("${first_argument_must_be_a_desc}")
            my_function(TRUE TRUE)
        endfunction()

        ct_add_section(NAME "second_argument_must_be_a_bool" EXPECTFAIL)
        function("${second_argument_must_be_a_bool}")
            my_function(hello world)
        endfunction()

        ct_add_section(NAME "function_only_takes_two_arguments" EXPECTFAIL)
        function("${function_only_takes_two_arguments}")
            my_function(hello TRUE 42)
        endfunction()
    endfunction()
endfunction()
