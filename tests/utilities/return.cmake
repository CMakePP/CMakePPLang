include(cmake_test/cmake_test)

ct_add_test("return")
    include(cmakepp_core/utilities/return)

    # Define a dummy function which uses the return function
    function(dummy_fxn)
        set(the_return "hello world")
        cpp_return(the_return)
    endfunction()

    ct_add_section("Ensure return was not defined to begin with")
        ct_assert_not_defined(the_return)
    ct_end_section()

    ct_add_section("Test that return actually returns")
        dummy_fxn()
        ct_assert_equal(the_return "hello world")
    ct_end_section()

ct_end_test()
