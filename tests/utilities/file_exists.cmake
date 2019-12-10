include(cmake_test/cmake_test)

ct_add_test("cpp_file_exists")
    include(cmakepp_core/utilities/file_exists)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be desc")
            cpp_file_exists(TRUE "${CMAKE_CURRENT_LIST_FILE}")
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2 must be path")
            cpp_file_exists(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is path")
        ct_end_section()

        ct_add_section("Takes two arguments")
            cpp_file_exists(result "${CMAKE_CURRENT_LIST_FILE}" hello)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("File exists")
        cpp_file_exists(result "${CMAKE_CURRENT_LIST_FILE}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("File does not exist")
        cpp_file_exists(result "${CMAKE_CURRENT_BINARY_DIR}/not_a_file.txt")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Is a directory")
        cpp_file_exists(result "${CMAKE_CURRENT_BINARY_DIR}")
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
