include(cmake_test/cmake_test)

ct_add_test(NAME "define_extension_function")
function("${define_extension_function}")

    cpp_class(MyClass)

        # Class with no members

    cpp_end_class()

    # Adding an extension function
    cpp_member(my_fxn MyClass type_a type_b)
    function("${my_fxn}" self param_a param_b)

        # The body of the function

        # ${self} can be used to access the instance of MyClass
        # the function is being called with

        # ${param_a} and ${param_b} can be used to access the
        # values of the parameters passed into the function

    endfunction()

endfunction()