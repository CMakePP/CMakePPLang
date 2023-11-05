include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_serialize_list]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/serialization/detail/serialize_list)

    ct_add_section(NAME [[empty_list]])
    function("${CMAKETEST_SECTION}")
        _cpp_serialize_list(result "")
        ct_assert_equal(result "[ ]")
    endfunction()

    ct_add_section(NAME [[one_item_list]])
    function("${CMAKETEST_SECTION}")
        _cpp_serialize_list(result "hello")
        ct_assert_equal(result "[ \"hello\" ]")
    endfunction()

    ct_add_section(NAME [[two_item_list]])
    function("${CMAKETEST_SECTION}")
        _cpp_serialize_list(result "hello;world")
        ct_assert_equal(result "[ \"hello\", \"world\" ]")
    endfunction()

    ct_add_section(NAME [[nested_list]])
    function("${CMAKETEST_SECTION}")
        set(nested_list a;aa;b\\\;bb\\\;c\\\\\;cc\\\\\;ccc\\\;d\\\\\;dd\\\\\;ddd\\\;bbb\\\;bbbb;aaa;aaaa)
        _cpp_serialize_list(result "${nested_list}")
        ct_assert_equal(result "[ \"a\", \"aa\", [ \"b\", \"bb\", [ \"c\", \"cc\", \"ccc\" ], [ \"d\", \"dd\", \"ddd\" ], \"bbb\", \"bbbb\" ], \"aaa\", \"aaaa\" ]")
    endfunction()

endfunction()
