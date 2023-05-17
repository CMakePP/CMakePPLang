include(cmake_test/cmake_test)

ct_add_test(NAME "class_attributes")
function("${class_attributes}")
    include(cmakepp_lang/cmakepp_lang)

    ct_add_section(NAME "declaring_attributes")
    function("${declaring_attributes}")

        cpp_class(MyClass)

            # Declare an attribute "color" with the default value "red"
            cpp_attr(MyClass color red)

            # Declare an attribute "size" with the default value "10"
            cpp_attr(MyClass size 10)

        cpp_end_class()

    endfunction()

endfunction()
