include(cmake_test/cmake_test)

ct_add_test("cpp_overload_ctor")
    include(cmakepp_core/overload/ctor)

    cpp_overload_ctor(an_overload a_fxn)
    cpp_object(PRINT "${an_overload}")
    message(FATAL_ERROR "Testing")
ct_end_test()
