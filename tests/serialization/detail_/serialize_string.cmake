include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_serialize_string")
function("${test__cpp_serialize_string}")
    include(cmakepp_lang/serialization/detail_/serialize_string)

    _cpp_serialize_string(result "hello world")
    ct_assert_equal(result [["hello world"]])
endfunction()
