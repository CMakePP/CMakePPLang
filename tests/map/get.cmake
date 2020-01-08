include(cmake_test/cmake_test)

ct_add_test("cpp_map_get")
    include(cmakepp_core/map/map)

    cpp_map_ctor(a_map)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be map")
            cpp_map_get(TRUE result key)
            ct_assert_fails_as("Assertion: bool is convertible to map failed.")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            cpp_map_get("${a_map}" TRUE key)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments")
            cpp_map_get("${a_map}" result key hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("get an empty value")
        cpp_map_set("${a_map}" foo "")
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result "")
    ct_end_section()

    ct_add_section("Get a normal value")
        cpp_map_set("${a_map}" foo bar)
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result bar)
    ct_end_section()

    ct_add_section("Get a value with a space")
        cpp_map_set("${a_map}" foo "hello world")
        cpp_map_get("${a_map}" result foo)
        ct_assert_equal(result "hello world")
    ct_end_section()

    ct_add_section("Get a list value")
        include(cmakepp_core/utilities/compare_lists)
        set(corr hello world)
        cpp_map_set("${a_map}" foo "${corr}")
        cpp_map_get("${a_map}" value foo)
        cpp_compare_lists(result value corr)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Get a non-existing value")
        cpp_map_get("${a_map}" result not_a_key)
        ct_assert_equal(result "")
    ct_end_section()
ct_end_test()

