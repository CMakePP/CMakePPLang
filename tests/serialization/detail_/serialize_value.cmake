include(cmake_test/cmake_test)

ct_add_test("_cpp_serialize_value")
    include(cmakepp_core/serialization/detail_/serialize_value)

    ct_add_section("Serializes an obj")
        include(cmakepp_core/algorithm/contains)
        include(cmakepp_core/object/object)

        _cpp_serialize_value(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")

        # This is just a small part of the actual result, but should be enough
        # to know it got serialized as an object
        set(corr [[{ "_cpp_attrs" : { }, "_cpp_fxns" : {]])
        cpp_contains(result "${corr}" "${result}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Serializes a list")
        _cpp_serialize_value(result [[hello;world]])
        ct_assert_equal(result "[ \"hello\", \"world\" ]")
    ct_end_section()

    ct_add_section("Serializes a map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map foo bar hello world)
        _cpp_serialize_value(result "${a_map}")
        ct_assert_equal(result [[{ "foo" : "bar", "hello" : "world" }]])
    ct_end_section()

    ct_add_section("Types that get serialized as strings")
        ct_add_section("bool")
            _cpp_serialize_value(result TRUE)
            ct_assert_equal(result [["TRUE"]])
        ct_end_section()

        ct_add_section("desc")
            _cpp_serialize_value(result "hello world")
            ct_assert_equal(result [["hello world"]])
        ct_end_section()

        ct_add_section("path")
            _cpp_serialize_value(result "${CMAKE_CURRENT_BINARY_DIR}")
            ct_assert_equal(result "\"${CMAKE_CURRENT_BINARY_DIR}\"")
        ct_end_section()

        ct_add_section("float")
            _cpp_serialize_value(result 3.14)
            ct_assert_equal(result [["3.14"]])
        ct_end_section()

        ct_add_section("int")
            _cpp_serialize_value(result 42)
            ct_assert_equal(result [["42"]])
        ct_end_section()

        ct_add_section("type")
            _cpp_serialize_value(result int)
            ct_assert_equal(result [["int"]])
        ct_end_section()
    ct_end_section()
ct_end_test()
