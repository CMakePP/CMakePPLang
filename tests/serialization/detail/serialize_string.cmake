include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_serialize_string]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/serialization/detail/serialize_string)

    _cpp_serialize_string(result "hello world")
    ct_assert_equal(result [["hello world"]])
endfunction()
