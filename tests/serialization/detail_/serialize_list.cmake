include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_list")
    include(cmakepp_core/serialization/detail_/serialize_list)

    ct_add_section("empty list")
        _cpp_serialize_list(result "")
        ct_assert_equal(result "[ ]")
    ct_end_section()

    ct_add_section("one-item list")
        _cpp_serialize_list(result "hello")
        ct_assert_equal(result "[ \"hello\" ]")
    ct_end_section()

    ct_add_section("two-item list")
        _cpp_serialize_list(result "hello;world")
        ct_assert_equal(result "[ \"hello\", \"world\" ]")
    ct_end_section()

    ct_add_section("nested list")
        set(nested_list a;aa;b\\\;bb\\\;c\\\\\;cc\\\\\;ccc\\\;d\\\\\;dd\\\\\;ddd\\\;bbb\\\;bbbb;aaa;aaaa)
        _cpp_serialize_list(result "${nested_list}")
        ct_assert_equal(result "[ \"a\", \"aa\", [ \"b\", \"bb\", [ \"c\", \"cc\", \"ccc\" ], [ \"d\", \"dd\", \"ddd\" ], \"bbb\", \"bbbb\" ], \"aaa\", \"aaaa\" ]")
    ct_end_section()

ct_end_test()
