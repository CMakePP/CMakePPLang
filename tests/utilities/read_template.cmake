include(cmake_test/cmake_test)

ct_add_test("cpp_read_template")
    include(cmakepp_core/utilities/read_template)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: desc")
            cpp_read_template(TRUE ${CMAKE_CURRENT_BINARY_DIR})
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: path")
            cpp_read_template(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is path")
        ct_end_section()
    ct_end_section()

    ct_add_section("No special characters")
        file(
            WRITE "${CMAKE_BINARY_DIR}/test1.txt"
            "some line of text\nanother line of text"
        )
        cpp_read_template(lines "${CMAKE_BINARY_DIR}/test1.txt")
        cpp_array(GET e0 "${lines}" 0)
        ct_assert_equal(e0 "some line of text")
        cpp_array(GET e1 "${lines}" 1)
        ct_assert_equal(e1 "another line of text")
    ct_end_section()

    ct_add_section("A semicolon")
        file(
            WRITE "${CMAKE_BINARY_DIR}/test2.txt"
            [[this line has a ; in it]]
        )
        cpp_read_template(lines "${CMAKE_BINARY_DIR}/test2.txt")
        cpp_array(GET e0 "${lines}" 0)
        ct_assert_equal(e0 [[this line has a ; in it]])
    ct_end_section()

    ct_add_section("A dollar sign")
        file(
            WRITE "${CMAKE_BINARY_DIR}/test3.txt"
            [[this line has a \${var} in it]]
        )
        cpp_read_template(lines "${CMAKE_BINARY_DIR}/test3.txt")
        cpp_array(GET e0 "${lines}" 0)
        ct_assert_equal(e0 [[this line has a \${var} in it]])
    ct_end_section()

    ct_add_section("An endline character")
        file(
            WRITE "${CMAKE_BINARY_DIR}/test4.txt"
            [[this line has a \n in it]]
        )
        cpp_read_template(lines "${CMAKE_BINARY_DIR}/test4.txt")
        cpp_array(GET e0 "${lines}" 0)
        ct_assert_equal(e0 [[this line has a \n in it]])
    ct_end_section()
ct_end_test()
