include(cmake_test/cmake_test)

ct_add_test(NAME [[test__cpp_serialize_value]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/serialization/detail/serialize_value)

    ct_add_section(NAME [[serialize_obj]])
    function("${CMAKETEST_SECTION}")
        include(cmakepp_lang/algorithm/contains)
        include(cmakepp_lang/object/object)

        _cpp_serialize_value(result "${__CMAKEPP_LANG_OBJECT_SINGLETON__}")

        # This is just a small part of the actual result, but should be enough
        # to know it got serialized as an object
        set(corr [[{ "_cpp_attrs" : { }, "_cpp_fxns" : {]])
        cpp_contains(result "${corr}" "${result}")
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME [[serialize_list]])
    function("${CMAKETEST_SECTION}")
        _cpp_serialize_value(result [[hello;world]])
        ct_assert_equal(result "[ \"hello\", \"world\" ]")
    endfunction()

    ct_add_section(NAME [[serialize_map]])
    function("${CMAKETEST_SECTION}")
        include(cmakepp_lang/map/map)
        cpp_map(CTOR a_map foo bar hello world)
        _cpp_serialize_value(result "${a_map}")
        ct_assert_equal(result [[{ "foo" : "bar", "hello" : "world" }]])
    endfunction()

    ct_add_section(NAME [[types_as_strings]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[bool]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result TRUE)
            ct_assert_equal(result [["TRUE"]])
        endfunction()

        ct_add_section(NAME [[desc]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result "hello world")
            ct_assert_equal(result [["hello world"]])
        endfunction()

        ct_add_section(NAME [[path]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result "${CMAKE_CURRENT_BINARY_DIR}")
            ct_assert_equal(result "\"${CMAKE_CURRENT_BINARY_DIR}\"")
        endfunction()

        ct_add_section(NAME [[float]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result 3.14)
            ct_assert_equal(result [["3.14"]])
        endfunction()

        ct_add_section(NAME [[int]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result 42)
            ct_assert_equal(result [["42"]])
        endfunction()

        ct_add_section(NAME [[type]])
        function("${CMAKETEST_SECTION}")
            _cpp_serialize_value(result int)
            ct_assert_equal(result [["int"]])
        endfunction()
    endfunction()
endfunction()
