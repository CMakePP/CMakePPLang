include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_string")
    include(cmakepp_core/serialization/detail_/serialize_string)

    _cpp_serialize_string(result "hello world")
    ct_assert_equal(result [["hello world"]])
ct_end_test()
