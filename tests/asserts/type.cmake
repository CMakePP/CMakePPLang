include(cmake_test/cmake_test)

ct_add_test(NAME [[_test_cpp_assert_type]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/asserts/type)
    set(CMAKEPP_LANG_DEBUG_MODE ON)

    ct_add_section(NAME [[assert_type_sig]])
    function("${CMAKETEST_SECTION}")

        ct_add_section(NAME [[assert_sig_first_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_type(TRUE TRUE)
        endfunction()

        ct_add_section(NAME [[assert_sig_too_many_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_type(bool TRUE hello)
        endfunction()

    endfunction()

    ct_add_section(NAME [[assert_type_primitives]])
    function("${CMAKETEST_SECTION}")

        ct_add_section(NAME [[assert_type_right_type]])
        function("${CMAKETEST_SECTION}")
            cpp_assert_type(int 1)
        endfunction()

        ct_add_section(NAME [[assert_type_wrong_type]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_assert_type(int TRUE)
        endfunction()

    endfunction()


    ct_add_section(NAME [[assert_type_classes]])
    function("${CMAKETEST_SECTION}")
        include(cmakepp_lang/class/class)

        if(NOT DEFINED _assert_type_classes_setup)
             cpp_class(BaseClass)

             cpp_class(MyClass BaseClass)

             set(_assert_type_classes_setup TRUE PARENT_SCOPE) #Persist whether we've ran setup
        endif()


        ct_add_section(NAME [[assert_type_same_class]])
        function("${CMAKETEST_SECTION}")
            BaseClass(CTOR a_base_class)
            cpp_assert_type(BaseClass "${a_base_class}")
        endfunction()

        ct_add_section(NAME [[assert_type_upcast]])
        function("${CMAKETEST_SECTION}")
            MyClass(CTOR my_class)
            cpp_assert_type(BaseClass "${my_class}")
        endfunction()

        ct_add_section(NAME [[assert_type_downcast]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            BaseClass(CTOR a_base_class)
            cpp_assert_type(MyClass "${a_base_class}")
        endfunction()
    endfunction()
endfunction()
