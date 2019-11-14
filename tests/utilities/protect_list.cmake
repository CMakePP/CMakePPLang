include(cmake_test/cmake_test)

ct_add_test("protect_list")
    include(cmakepp_core/utilities/protect_list)
    set(a_list 1 2 3)
    protect_list(a_list)
    ct_assert_equal(a_list "1\\;2\\;3")
ct_end_test()
