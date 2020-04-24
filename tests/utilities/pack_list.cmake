include(cmake_test/cmake_test)

ct_add_test("cpp_pack_list")
    include(cmakepp_core/utilities/pack_list)
    include(cmakepp_core/serialization/serialization)

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 delim)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th Argument must be desc")
            cpp_pack_list(TRUE hello)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

    ct_end_section()

    ct_add_section("Single string")
        ct_add_section("Simple string")
            set(flat_list "abc")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "abc")
        ct_end_section()

        ct_add_section("String with spaces")
            set(flat_list "a b c")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "a b c")
        ct_end_section()
    ct_end_section()

    ct_add_section("Simple flat list")
        # Set correct result (same for all sections)
        set(corr "a_${delim}_0_${delim}_aa_${delim}_0_${delim}_aaa_${delim}_0_${delim}_aaaa")

        ct_add_section("List declared with semicolons and no quotes")
            set(flat_list a;aa;aaa;aaaa)
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        ct_end_section()

        ct_add_section("List declared with semicolons with quotes")
            set(flat_list "a;aa;aaa;aaaa")
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        ct_end_section()

        ct_add_section("List declared with elements as seperate args")
            set(flat_list a aa aaa aaaa)
            cpp_pack_list(result "${flat_list}")
            ct_assert_equal(result "${corr}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Nested list")
        set(corr "a_${delim}_0_${delim}_b_${delim}_1_${delim}_c_${delim}_2_${delim}_cc_${delim}_2_${delim}_cc_${delim}_1_${delim}_bb_${delim}_1_${delim}_bbb_${delim}_0_${delim}_aaa")
        set(nested_list a;b\\\;c\\\\\;cc\\\\\;cc\\\;bb\\\;bbb;aaa)
        cpp_pack_list(result "${nested_list}")
        ct_assert_equal(result "${corr}")
    ct_end_section()

ct_end_test()

ct_add_test("cpp_unpack_list")
    include(cmakepp_core/utilities/pack_list)

    # Use the end-of-tranmission as the delimiter for the packed list string
    string(ASCII 04 delim)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section("0th Argument must be desc")
            cpp_unpack_list(TRUE hello)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("1st Argument must be desc")
            cpp_unpack_list(result TRUE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        ct_end_section()

        ct_add_section("Accepts exactly 2 arguments")
            cpp_unpack_list(result hello world)
            ct_assert_fails_as("Function takes 2 argument(s), but 3 was/were")
        ct_end_section()
    ct_end_section()

    # Unpack list and then serialize it to ensure it behaves like a proper
    # CMake nested list
    ct_add_section("Flat list")
        set(corr "[ \"a\", \"aa\", \"aaa\", \"aaaa\" ]")
        set(packed_flat_list "a_${delim}_0_${delim}_aa_${delim}_0_${delim}_aaa_${delim}_0_${delim}_aaaa")
        cpp_unpack_list(unpack_result "${packed_flat_list}")
        cpp_serialize(serialize_result "${unpack_result}")
        ct_assert_equal(serialize_result "${corr}")
    ct_end_section()

    ct_add_section("Nested list")
        set(corr "[ \"a\", [ \"b\", [ \"c\", \"cc\", \"cc\" ], \"bb\", \"bbb\" ], \"aaa\" ]")
        set(packed_nested_list "a_${delim}_0_${delim}_b_${delim}_1_${delim}_c_${delim}_2_${delim}_cc_${delim}_2_${delim}_cc_${delim}_1_${delim}_bb_${delim}_1_${delim}_bbb_${delim}_0_${delim}_aaa")
        cpp_unpack_list(unpack_result "${packed_nested_list}")
        cpp_serialize(serialize_result "${unpack_result}")
        ct_assert_equal(serialize_result "${corr}")
    ct_end_section()
ct_end_test()
