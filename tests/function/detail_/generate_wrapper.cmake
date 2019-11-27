include(cmake_test/cmake_test)

ct_add_test("_cpp_generate_wrapper")
    include("cmakepp_core/function/detail_/generate_wrapper")

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("Arg1 must be a path")
            _cpp_generate_wrapper(TRUE a_fxn)
            ct_assert_fails_as("Assertion: TRUE is path")
        ct_end_section()

        ct_add_section("Arg2 must be desc")
            _cpp_generate_wrapper("${CMAKE_CURRENT_BINARY_DIR}" TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Variadic arguments must be types")
            _cpp_generate_wrapper("${CMAKE_CURRENT_BINARY_DIR}" hello TRUE)
            ct_assert_fails_as("Assertion: TRUE is type")
        ct_end_section()
    ct_end_section()

    ct_add_section("Returns the mangled name")
        _cpp_generate_wrapper("${CMAKE_CURRENT_BINARY_DIR}" a_fxn int bool)
        _cpp_mangle_fxn(corr a_fxn int bool)
        ct_assert_equal(a_fxn "${corr}")
    ct_end_section()

ct_end_test()
