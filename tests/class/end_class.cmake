include(cmake_test/cmake_test)

ct_add_test("cpp_end_class")
    include(cmakepp_core/class/class)

    cpp_class(AClass)
        cpp_member(fxn1 AClass int bool)
        function("${fxn1}")
            message("In fxn1")
        endfunction()

        cpp_member(fxn2 AClass int int)
        function("${fxn2}")
            message("In fxn2")
        endfunction()

        cpp_member(fxn2 AClass int int int)
        function("${fxn2}")
            message("In fxn2 overload 2")
        endfunction()

    _cpp_get_class_registry(registry)
    include(cmakepp_core/serialization/serialization)
    cpp_serialize(result "${registry}")
    message(FATAL_ERROR "${result}")

    cpp_end_class()

ct_end_test()
