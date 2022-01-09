include(cmake_test/cmake_test)

ct_add_test("_cpp_object_equal")
    include(cmakepp_core/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th argument must be obj")
            _cpp_object_equal(TRUE result "${an_obj}")
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("1st argument must be desc")
            _cpp_object_equal("${an_obj}" TRUE "${an_obj}")
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("2nd argument must be obj")
            _cpp_object_equal("${an_obj}" result TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to obj failed.")
        ct_end_section()

        ct_add_section("Takes exactly 3 arguments")
            _cpp_object_equal("${an_obj}" result "${an_obj}" hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        ct_end_section()
    ct_end_section()

    ct_add_section("Equal objects")
        _cpp_object_equal("${an_obj}" result "${an_obj}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Different objects")
        _cpp_object_equal(
            "${an_obj}" result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}"
        )
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
