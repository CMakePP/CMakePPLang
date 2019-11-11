include(cmake_test/cmake_test)

#[[ Unit-testing strategy:
#
# cpp_enable_if_debug is supposed to return from a function early if
# CMAKEPP_CORE_DEBUG_MODE is not enabled. To test this we define a simple
# function which calls cpp_enable_if_debug and sets a variable IS_DEBUG to TRUE.
# We then test for the truthy-ness of this variable as appropriate.
#]]
ct_add_test("cpp_enable_if_debug")
    include(cmakepp_core/utilities/enable_if_debug)

    set(IS_DEBUG FALSE)
    function(test_enable_if_debug)
        cpp_enable_if_debug()
        set(IS_DEBUG TRUE PARENT_SCOPE)
    endfunction()

    ct_add_section("CMAKEPP_CORE_DEBUG_MODE not set")
        test_enable_if_debug()
        ct_assert_equal(IS_DEBUG FALSE)
    ct_end_section()

    ct_add_section("CMAKEPP_CORE_DEBUG_MODE set")
        set(CMAKEPP_CORE_DEBUG_MODE TRUE)
        test_enable_if_debug()
        ct_assert_equal(IS_DEBUG TRUE)
    ct_end_section()

ct_end_test()
