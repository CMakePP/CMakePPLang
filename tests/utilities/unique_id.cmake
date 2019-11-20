include(cmake_test/cmake_test)

#[[
# Ensuring that cpp_unique_id always generates a unique ID is impossible, rather
# we call it three times, in rapid succession, and test that the resulting
# identifiers are all unique.
#]]

ct_add_test("cpp_unique_id")
    include(cmakepp_core/utilities/unique_id)
    cpp_unique_id(result0)
    cpp_unique_id(result1)
    cpp_unique_id(result2)
    ct_assert_not_equal(result0 "${result1}")
    ct_assert_not_equal(result0 "${result2}")
    ct_assert_not_equal(result1 "${result2}")
ct_end_test()
