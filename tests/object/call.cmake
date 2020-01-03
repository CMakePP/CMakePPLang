include(cmake_test/cmake_test)

ct_add_test("_cpp_object_call_guts")
    include(cmakepp_core/object/object)

    _cpp_object_singleton(singleton)

    ct_add_section("Returns symbol for valid call")
        _cpp_object_call_guts("${singleton}" result "equal" huh "${singleton}")
        ct_assert_equal(result _cpp_obj_equal_obj_desc_obj_)
    ct_end_section()

    ct_add_section("Raises an error if symbol does not exist")
        _cpp_object_call_guts(
            "${singleton}" result "equal"
        )
        ct_assert_fails_as("No suitable overload of equal(obj)")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_object_call")
    include(cmakepp_core/object/object)

    _cpp_object_singleton(singleton)
    _cpp_object_call("${singleton}" "equal" result "${singleton}")
    ct_assert_equal(result TRUE)
ct_end_test()
