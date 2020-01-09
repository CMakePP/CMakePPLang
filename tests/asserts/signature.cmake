include(cmake_test/cmake_test)

#[[
# For sections which have no CMakeTest assertions, we are basically just making
# sure the function runs without problem. Also we don't have to test for the
# case where the user passed fewer than the required number of positional
# arguments as CMake will catch that one for us.
#]]

ct_add_test("cpp_assert_signature")
    include(cmakepp_core/asserts/signature)
    set(CMAKEPP_CORE_DEBUG_MODE ON)

    ct_add_section("Set number of arguments")
        ct_add_section("No arguments")
            cpp_assert_signature("")
        ct_end_section()

        ct_add_section("One argument")
            ct_add_section("Right type")
                cpp_assert_signature("TRUE" bool)
            ct_end_section()

            ct_add_section("Wrong type")
                cpp_assert_signature("TRUE" int)
                ct_assert_fails_as("Assertion: bool is convertible to int")
            ct_end_section()

            ct_add_section("Too many arguments")
                cpp_assert_signature("TRUE;FALSE" bool)
                ct_assert_fails_as("Function takes 1 argument(s), but 2 was/")
            ct_end_section()
        ct_end_section()

        ct_add_section("Two arguments")
            ct_add_section("Both right type")
                cpp_assert_signature("TRUE;42" bool int)
            ct_end_section()

            ct_add_section("First is wrong type")
                cpp_assert_signature("TRUE;42" int int)
                ct_assert_fails_as("Assertion: bool is convertible to int")
            ct_end_section()

            ct_add_section("Second is wrong type")
                cpp_assert_signature("TRUE;TRUE" bool int)
                ct_assert_fails_as("Assertion: bool is convertible to int")
            ct_end_section()

            ct_add_section("Too many arguments")
                cpp_assert_signature("TRUE;42;FALSE" bool int)
                ct_assert_fails_as("Function takes 2 argument(s), but 3 was/")
            ct_end_section()
        ct_end_section()
    ct_end_section()  # Set number of arguments

    ct_add_section("Only variadic arguments")
        ct_add_section("No arguments provided")
            cpp_assert_signature("" args)
        ct_end_section()

        ct_add_section("1 argument provided")
            cpp_assert_signature("TRUE" args)
        ct_end_section()

        ct_add_section("2 arguments provided")
            cpp_assert_signature("TRUE;42" args)
        ct_end_section()
    ct_end_section()

    ct_add_section("One positional and variadic arguments")
        ct_add_section("One argument provided: Right type")
            cpp_assert_signature("42" int args)
        ct_end_section()

        ct_add_section("One argument provided: Wrong type")
            cpp_assert_signature("TRUE" int args)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()

        ct_add_section("2 arguments provided: Right type")
            cpp_assert_signature("42;TRUE" int args)
        ct_end_section()

        ct_add_section("2 arguments provided: Wrong type")
            cpp_assert_signature("TRUE;TRUE" int args)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()
    ct_end_section()

    ct_add_section("Two positional and variadic arguments")
        ct_add_section("Two arguments provided: Right types")
            cpp_assert_signature("42;TRUE" int bool args)
        ct_end_section()

        ct_add_section("Two arguments provided: First wrong type")
            cpp_assert_signature("TRUE;TRUE" int bool args)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()

        ct_add_section("Two arguments provided: Second wrong type")
            cpp_assert_signature("42;42" int bool args)
            ct_assert_fails_as("Assertion: int is convertible to bool")
        ct_end_section()

        ct_add_section("3 arguments provided: Right types")
            cpp_assert_signature("42;TRUE;hello" int bool args)
        ct_end_section()

        ct_add_section("3 arguments provided: First wrong type")
            cpp_assert_signature("TRUE;TRUE;hello" int bool args)
            ct_assert_fails_as("Assertion: bool is convertible to int")
        ct_end_section()

        ct_add_section("3 arguments provided: Second wrong type")
            cpp_assert_signature("42;42;hello" int bool args)
            ct_assert_fails_as("Assertion: int is convertible to bool")
        ct_end_section()
    ct_end_section()

    ct_add_section("Can pass anything for a string")
        cpp_assert_signature("42" str)
    ct_end_section()

    ct_add_section("Works with an object")
        include(cmakepp_core/object/object)
        cpp_assert_signature("${__CMAKEPP_CORE_OBJECT_SINGLETON__}" obj)
    ct_end_section()

    ct_add_section("Fails if passes args twice")
        cpp_assert_signature("TRUE;42;FALSE" bool args args)
        ct_assert_fails_as("Assertion: 'args' is last type provided")
    ct_end_section()

ct_end_test()
