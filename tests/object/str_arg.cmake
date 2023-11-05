include(cmake_test/cmake_test)

cpp_class(MyClass)

    cpp_member(print_msg MyClass str)
    function("${print_msg}" self test_string)

        message("${test_string}")

    endfunction()

# Don't end the class so methods can be defined in the tests
# cpp_end_class()

ct_add_test(NAME [[test_str_arg_w_escaped_chars]])
function("${CMAKETEST_TEST}")

    ct_add_section(NAME [[test_no_escapes]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "teststring")
        ct_assert_prints("teststring")

        MyClass(print_msg "${my_obj}" "test string")
        ct_assert_prints("test string")

    endfunction()

    ct_add_section(NAME [[test_escaped_quotes]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "test \"string")
        ct_assert_prints("test \"string")

        MyClass(print_msg "${my_obj}" "String \"with quotes\"")
        ct_assert_prints("String \"with quotes\"")

        MyClass(print_msg "${my_obj}" "\"\"\"\"\"\"\"\"\"\"")
        ct_assert_prints("\"\"\"\"\"\"\"\"\"\"")

        set(a_var "String \"with quotes\"")
        MyClass(print_msg "${my_obj}" "${a_var}")
        ct_assert_prints("String \"with quotes\"")

    endfunction()

    ct_add_section(NAME [[test_escaped_dollar]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "test \$dollar")
        ct_assert_prints("test \$dollar")

        MyClass(print_msg "${my_obj}" "String \$with dollar\$")
        ct_assert_prints("String \$with dollar\$")

        MyClass(print_msg "${my_obj}" "\$\$\$\$\$\$\$\$\$\$")
        ct_assert_prints("\$\$\$\$\$\$\$\$\$\$")

        set(a_var "String \$with dollar\$")
        MyClass(print_msg "${my_obj}" "${a_var}")
        ct_assert_prints("String \$with dollar\$")

    endfunction()

    ct_add_section(NAME [[test_escaped_semicolon]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "test \;semicolon")
        ct_assert_prints("test \;semicolon")

        MyClass(print_msg "${my_obj}" "String \;with semicolon\;")
        ct_assert_prints("String \;with semicolon\;")

        MyClass(print_msg "${my_obj}" "\;\;\;\;\;\;\;\;\;\;")
        ct_assert_prints("\;\;\;\;\;\;\;\;\;\;")

        set(a_var "String \;with semicolon\;")
        MyClass(print_msg "${my_obj}" "${a_var}")
        ct_assert_prints("String \;with semicolon\;")

    endfunction()

    ct_add_section(NAME [[test_escaped_backslash]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        # Invalid character escape '\v'
        # MyClass(print_msg "${my_obj}" "test \\var")
        # ct_assert_prints("test \\var")

        MyClass(print_msg "${my_obj}" "test \\\\backslash")
        ct_assert_prints("test \\backslash")

        MyClass(print_msg "${my_obj}" "test \\\\backslash\\\\")
        ct_assert_prints("test \\backslash\\")

        MyClass(print_msg "${my_obj}" "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
        ct_assert_prints("\\\\\\\\\\\\\\\\\\\\")

        set(a_var "test \\\\backslash\\\\")
        MyClass(print_msg "${my_obj}" "${a_var}")
        ct_assert_prints("test \\backslash\\")

    endfunction()

    ct_add_section(NAME [[test_escaped_var_ref]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "test \\\${var}")
        ct_assert_prints("test \${var}")

        MyClass(print_msg "${my_obj}" "\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}\\\${var}")
        ct_assert_prints("\${var}\${var}\${var}\${var}\${var}\${var}\${var}\${var}\${var}\${var}")

        set(a_var "test \\\${var}")
        MyClass(print_msg "${my_obj}" "${a_var}")
        ct_assert_prints("test \${var}")

    endfunction()

    ct_add_section(NAME [[test_other_chars]])
    function("${CMAKETEST_SECTION}")

        MyClass(CTOR my_obj)

        MyClass(print_msg "${my_obj}" "test (var)")
        ct_assert_prints("test (var)")
        
        MyClass(print_msg "${my_obj}" "test {var{")
        ct_assert_prints("test {var{")

        MyClass(print_msg "${my_obj}" "test }var}")
        ct_assert_prints("test }var}")

        MyClass(print_msg "${my_obj}" "test {var}")
        ct_assert_prints("test {var}")

        MyClass(print_msg "${my_obj}" "test #var#")
        ct_assert_prints("test #var")

        MyClass(print_msg "${my_obj}" "test 'var'")
        ct_assert_prints("test 'var")

        MyClass(print_msg "${my_obj}" "test @var@")
        ct_assert_prints("test @var@")

        MyClass(print_msg "${my_obj}" "test ^var^")
        ct_assert_prints("test ^var^")

        MyClass(print_msg "${my_obj}" "test /var/")
        ct_assert_prints("test /var/")

        MyClass(print_msg "${my_obj}" "test &var&")
        ct_assert_prints("test &var&")

    endfunction()

    ct_add_section(NAME [[test_multiple_args]])
    function("${CMAKETEST_SECTION}")

        ct_add_section(NAME [[test_two_args]])
        function("${CMAKETEST_SECTION}")
            cpp_member(print_msg MyClass int str)
            function("${print_msg}" self test_int test_string)

                message("${test_string}")

            endfunction()

            cpp_member(print_msg MyClass str int)
            function("${print_msg}" self test_string test_int)

                message("${test_string}")

            endfunction()

            MyClass(CTOR my_obj)

            MyClass(print_msg "${my_obj}" "\"\$" 42)
            ct_assert_prints("\"\$")

            MyClass(print_msg "${my_obj}" 42 "\"\$")
            ct_assert_prints("\"\$")
        endfunction()

        ct_add_section(NAME [[test_three_args]])
        function("${CMAKETEST_SECTION}")
            cpp_member(print_msg MyClass int str int)
            function("${print_msg}" self test_int test_string test_int2)

                message("${test_string}")

            endfunction()

            MyClass(CTOR my_obj)

            MyClass(print_msg "${my_obj}" 42 "\"\$" 2)
            ct_assert_prints("\"\$")
        endfunction()

    endfunction()

endfunction()
