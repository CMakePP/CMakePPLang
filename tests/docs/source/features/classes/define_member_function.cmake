include(cmake_test/cmake_test)

ct_add_test(NAME [[define_member_function]])
function("${CMAKETEST_TEST}")

    cpp_class(MyClass)

        cpp_member(my_fxn MyClass type_a type_b)
        function("${my_fxn}" self param_a param_b)

            # The body of the function

            # ${self} can be used to access the instance of MyClass
            # the function is being called with

            # ${param_a} and ${param_b} can be used to access the
            # values of the parameters passed into the function

        endfunction()

    cpp_end_class()

endfunction()
