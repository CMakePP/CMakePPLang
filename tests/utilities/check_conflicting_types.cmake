include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_check_conflicting_types]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/check_conflicting_types)

    ct_add_section(NAME [[test_conflicts]])
    function("${CMAKETEST_SECTION}")

        #[[[
        # Ease-of-testing function to test that verifies that a given string
        # exactly matches a built-in type with ``cpp_check_conflicting_types``.
        #
        # :param type: String that must exactly match a built-in type for
        #                  the test to succeed.
        # :type type: desc
        #]]
        function(test_exact_conflict _tc_type)

            cpp_check_conflicting_types(_is_conflict _conflicting_type "${_tc_type}")
            
            # Output to help determine which type is failing
            if(NOT _is_conflict)
                message("-- test_exact_conflict failed on: ${_tc_type}")
            endif()

            ct_assert_equal(_is_conflict TRUE)
            ct_assert_equal(_conflicting_type "${_tc_type}")

        endfunction()

        # List of built-in data types for CMakePPLang
        set(
            _cpp_types
            bool fxn path float genexpr int list str target desc type class map obj
        )

        # Test each data type
        foreach(_cpp_type_i ${_cpp_types})
            test_exact_conflict("${_cpp_type_i}")
        endforeach()

    endfunction()

    ct_add_section(NAME [[test_no_conflicts]])
    function("${CMAKETEST_SECTION}")

        ct_add_section(NAME [[test_underscores]])
        function("${CMAKETEST_SECTION}")

            cpp_check_conflicting_types(
                _is_conflict _conflicting_type "not_a_type"
            )

            ct_assert_equal(_is_conflict FALSE)
            ct_assert_equal(_conflicting_type "")

        endfunction()

        ct_add_section(NAME [[test_capitalization]])
        function("${CMAKETEST_SECTION}")

            cpp_check_conflicting_types(_is_conflict _conflicting_type "Target")

            ct_assert_equal(_is_conflict FALSE)
            ct_assert_equal(_conflicting_type "")

        endfunction()

    endfunction()

endfunction()
