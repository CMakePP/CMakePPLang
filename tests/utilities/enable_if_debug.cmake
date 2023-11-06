include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# cpp_enable_if_debug is supposed to return from a function early if
# CMAKEPP_LANG_DEBUG_MODE is not enabled. To test this we define a simple
# function which calls cpp_enable_if_debug and sets a variable IS_DEBUG to TRUE.
# We then test for the truthy-ness of this variable as appropriate.
#]]
ct_add_test(NAME [[test_cpp_enable_if_debug]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/enable_if_debug)

    ct_add_section(NAME [[test_signature]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_enable_if_debug(hello)
    endfunction()

    ct_add_section(NAME [[typical_use_case]])
    function("${CMAKETEST_SECTION}")

        set(IS_DEBUG FALSE)
        function(test_enable_if_debug)
            cpp_enable_if_debug()
            set(IS_DEBUG TRUE PARENT_SCOPE)
        endfunction()

        ct_add_section(NAME [[debug_mode_not_set_leaves_is_debug_alone]])
        function("${CMAKETEST_SECTION}")
            test_enable_if_debug()
            ct_assert_equal(IS_DEBUG FALSE)
        endfunction()

        ct_add_section(NAME [[debug_mode_false_leaves_is_debug_alone]])
        function("${CMAKETEST_SECTION}")
            set(CMAKEPP_LANG_DEBUG_MODE FALSE)
            test_enable_if_debug()
            ct_assert_equal(IS_DEBUG FALSE)
        endfunction()

        ct_add_section(NAME [[debug_mode_true_sets_is_debug]])
        function("${CMAKETEST_SECTION}")
            set(CMAKEPP_LANG_DEBUG_MODE TRUE)
            test_enable_if_debug()
            ct_assert_equal(IS_DEBUG TRUE)
        endfunction()
    endfunction()
endfunction()
