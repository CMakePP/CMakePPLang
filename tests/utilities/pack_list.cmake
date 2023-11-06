include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_pack_list]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/pack_list)
    include(cmakepp_lang/serialization/serialization)

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 delim)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_pack_list(TRUE hello)
        endfunction()

    endfunction()

    ct_add_section(NAME [[single_string]])
    function("${CMAKETEST_SECTION}")
        ct_add_section(NAME [[simple_string]])
        function("${CMAKETEST_SECTION}")
            set(flat_list "abc")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "abc")
        endfunction()

        ct_add_section(NAME [[string_with_spaces]])
        function("${CMAKETEST_SECTION}")
            set(flat_list "a b c")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "a b c")
        endfunction()
    endfunction()

    ct_add_section(NAME [[simple_flat_list]])
    function("${CMAKETEST_SECTION}")
        # Set correct result (same for all sections)
        set(corr "a_${delim}_0_${delim}_aa_${delim}_0_${delim}_aaa_${delim}_0_${delim}_aaaa")

        ct_add_section(NAME [[list_semicolons_no_quotes]])
        function("${CMAKETEST_SECTION}")
            set(flat_list a;aa;aaa;aaaa)
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        endfunction()

        ct_add_section(NAME [[list_semicolons_quotes]])
        function("${CMAKETEST_SECTION}")
            set(flat_list "a;aa;aaa;aaaa")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        endfunction()

        ct_add_section(NAME [[list_separate_args]])
        function("${CMAKETEST_SECTION}")
            set(flat_list a aa aaa aaaa)
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        endfunction()
    endfunction()

    ct_add_section(NAME [[nested_list]])
    function("${CMAKETEST_SECTION}")
        set(corr "a_${delim}_0_${delim}_b_${delim}_1_${delim}_c_${delim}_2_${delim}_cc_${delim}_2_${delim}_cc_${delim}_1_${delim}_bb_${delim}_1_${delim}_bbb_${delim}_0_${delim}_aaa")
        set(nested_list a;b\\\;c\\\\\;cc\\\\\;cc\\\;bb\\\;bbb;aaa)
        cpp_pack_list(result "${nested_list}")
        ct_assert_equal(result "${corr}")
    endfunction()

endfunction()

ct_add_test(NAME [[test_cpp_unpack_list]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/pack_list)

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 delim)

    ct_add_section(NAME [[test_signature]])
    function("${CMAKETEST_SECTION}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME [[first_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_unpack_list(TRUE hello)
        endfunction()

        ct_add_section(NAME [[second_arg_desc]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_unpack_list(result TRUE)
        endfunction()

        ct_add_section(NAME [[takes_two_args]] EXPECTFAIL)
        function("${CMAKETEST_SECTION}")
            cpp_unpack_list(result hello world)
        endfunction()
    endfunction()

    # Unpack list and then serialize it to ensure it behaves like a proper
    # CMake nested list
    ct_add_section(NAME [[flat_list]])
    function("${CMAKETEST_SECTION}")
        set(corr "[ \"a\", \"aa\", \"aaa\", \"aaaa\" ]")
        set(packed_flat_list "a_${delim}_0_${delim}_aa_${delim}_0_${delim}_aaa_${delim}_0_${delim}_aaaa")
        cpp_unpack_list(unpack_result "${packed_flat_list}")
        cpp_serialize(serialize_result "${unpack_result}")
        ct_assert_equal(serialize_result "${corr}")
    endfunction()

    ct_add_section(NAME [[nested_list]])
    function("${CMAKETEST_SECTION}")
        set(corr "[ \"a\", [ \"b\", [ \"c\", \"cc\", \"cc\" ], \"bb\", \"bbb\" ], \"aaa\" ]")
        set(packed_nested_list "a_${delim}_0_${delim}_b_${delim}_1_${delim}_c_${delim}_2_${delim}_cc_${delim}_2_${delim}_cc_${delim}_1_${delim}_bb_${delim}_1_${delim}_bbb_${delim}_0_${delim}_aaa")
        cpp_unpack_list(unpack_result "${packed_nested_list}")
        cpp_serialize(serialize_result "${unpack_result}")
        ct_assert_equal(serialize_result "${corr}")
    endfunction()
endfunction()
