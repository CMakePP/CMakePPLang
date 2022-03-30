include(cmake_test/cmake_test)

cpp_class(MyClass)

    cpp_member(print_msg MyClass str)
    function("${print_msg}" self test_string)

        message("---- ${test_string}")

    endfunction()

# Don't end the class so methods can be defined in the tests
# cpp_end_class()

ct_add_test(NAME "test_str_arg_w_escaped_chars")
function("${test_str_arg_w_escaped_chars}")

    ct_add_section(NAME "test_escaped_quotes")
    function("${test_escaped_quotes}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "teststring")
        ct_assert_prints("teststring")

        MyClass(print_msg "${my_obj}" "test string")
        ct_assert_prints("test string")

        MyClass(print_msg "${my_obj}" "test \"string")
        ct_assert_prints("test \"string")

        MyClass(print_msg "${my_obj}" "String \"with quotes\"")
        ct_assert_prints("String \"with quotes\"")

        MyClass(print_msg "${my_obj}" "\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"")
        ct_assert_prints("\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"")

    endfunction()

endfunction()
