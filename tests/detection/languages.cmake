ct_add_test(NAME test_cpp_enabled_languages)
function(${test_cpp_enabled_languages})
    include(cmakepp_lang/detection/languages)

    #cpp_enabled_languages(the_languages)
    #set(correct "NONE")
    #ct_assert_equal(the_languages "${correct}")

    enable_language(C)
    cpp_enabled_languages(the_languages)
    set(correct "C")
    ct_assert_equal(the_languages "${correct}")

    enable_language(CXX)
    cpp_enabled_languages(the_languages)
    set(correct "C" "CXX")
    ct_assert_equal(the_languages "${correct}")
endfunction()

