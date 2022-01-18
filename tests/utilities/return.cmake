include(cmake_test/cmake_test)

ct_add_test(NAME "test_return")
function("${test_return}")
    include(cmakepp_core/utilities/return)

    # Define a dummy function which uses the return function
    function(dummy_fxn)
        set(the_return "hello world")
        cpp_return(the_return)
    endfunction()

    ct_add_section(NAME "ensure_the_return_not_defined")
    function("${ensure_the_return_not_defined}")
        ct_assert_not_defined(the_return)
    endfunction()

    ct_add_section(NAME "return_equals_hello_world")
    function("${return_equals_hello_world}")
        dummy_fxn()
        ct_assert_equal(the_return "hello world")
    endfunction()

endfunction()
