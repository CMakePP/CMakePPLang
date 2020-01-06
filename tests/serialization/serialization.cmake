include(cmake_test/cmake_test)

ct_add_test("cpp_serialize")
    include(cmakepp_core/serialization/serialization)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th Argument must be desc")
            cpp_serialize(TRUE hello)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Accepts exactly 2 arguments")
            cpp_serialize(result hello world)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Simple serialization")
        cpp_serialize(result "hello world")
        ct_assert_equal(result [["hello world"]])
    ct_end_section()

    ct_add_section("Complicated Nested Serialization")
        set(a_list 1 2 3)
        cpp_map(CTOR a_map foo bar)
        cpp_map(SET "${a_map}" a_list "${a_list}")

        set(corr [[{ "foo" : "bar", "a_list" : [ "1", "2", "3" ] }]])
        cpp_serialize(result "${a_map}")
        ct_assert_equal(result "${corr}")
    ct_end_section()
ct_end_test()
