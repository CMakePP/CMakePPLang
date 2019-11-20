include(cmake_test/cmake_test)

ct_add_test("_cpp_class_ctor")
    include(cmakepp_core/class/detail_/ctor)

    ct_add_section("No base class")
        _cpp_class_ctor(result a_new_type)

        ct_add_section("Base class list")
            cpp_map(GET base_classes "${result}" base_classes)
            cpp_array(GET result "${base_classes}" 0)
            ct_assert_equal(result object)
        ct_end_section()

        ct_add_section("Implementation file")
            cpp_map(GET impl_file "${result}" impl_file)
            ct_assert_equal(
                impl_file
                "${CMAKE_CURRENT_BINARY_DIR}/cpp_classes/a_new_type.cmake"
            )
        ct_end_section()

        ct_add_section("Type")
            cpp_map(GET type "${result}" my_type)
            ct_assert_equal(type "a_new_type")
        ct_end_section()

        ct_add_section("Source file")
            cpp_map(GET src_file "${result}" src_file)
            ct_assert_equal(src_file "${CMAKE_CURRENT_LIST_FILE}")
        ct_end_section()
    ct_end_section()

    ct_add_section("One base class")
        _cpp_class_ctor(result a_new_type base1)

        ct_add_section("Base class list")
            cpp_map(GET base_classes "${result}" base_classes)
            cpp_array(GET result "${base_classes}" 0)
            ct_assert_equal(result object)
            cpp_array(GET result "${base_classes}" 1)
            ct_assert_equal(result base1)
        ct_end_section()

        ct_add_section("Implementation file")
            cpp_map(GET impl_file "${result}" impl_file)
            ct_assert_equal(
                impl_file
                "${CMAKE_CURRENT_BINARY_DIR}/cpp_classes/a_new_type.cmake"
            )
        ct_end_section()

        ct_add_section("Type")
            cpp_map(GET type "${result}" my_type)
            ct_assert_equal(type "a_new_type")
        ct_end_section()

        ct_add_section("Source file")
            cpp_map(GET src_file "${result}" src_file)
            ct_assert_equal(src_file "${CMAKE_CURRENT_LIST_FILE}")
        ct_end_section()
    ct_end_section()

    ct_add_section("Two base classes")
        _cpp_class_ctor(result a_new_type base1 base2)

        ct_add_section("Base class list")
            cpp_map(GET base_classes "${result}" base_classes)
            cpp_array(GET result "${base_classes}" 0)
            ct_assert_equal(result object)
            cpp_array(GET result "${base_classes}" 1)
            ct_assert_equal(result base1)
            cpp_array(GET result "${base_classes}" 2)
            ct_assert_equal(result base2)
        ct_end_section()

        ct_add_section("Implementation file")
            cpp_map(GET impl_file "${result}" impl_file)
            ct_assert_equal(
                impl_file
                "${CMAKE_CURRENT_BINARY_DIR}/cpp_classes/a_new_type.cmake"
            )
        ct_end_section()

        ct_add_section("Type")
            cpp_map(GET type "${result}" my_type)
            ct_assert_equal(type "a_new_type")
        ct_end_section()

        ct_add_section("Source file")
            cpp_map(GET src_file "${result}" src_file)
            ct_assert_equal(src_file "${CMAKE_CURRENT_LIST_FILE}")
        ct_end_section()
    ct_end_section()
ct_end_test()
