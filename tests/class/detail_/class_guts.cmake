include(cmake_test/cmake_test)

ct_add_test("_cpp_class_guts")
    include(cmakepp_core/class/detail_/class_guts)
    include(cmakepp_core/algorithm/equal)

    _cpp_get_class_registry(registry)

    ct_add_section("class does not exist in registry")
        cpp_map(HAS_KEY exists "${registry}" MyFirstClass)
        ct_assert_equal(exists FALSE)
    ct_end_section()

    ct_add_section("Add class with no base class")
        _cpp_class_guts(impl_file MyFirstClass)

        ct_add_section("Returns a false value")
            ct_assert_equal(impl_file FALSE)
        ct_end_section()

        ct_add_section("Now in registry")
            cpp_map(HAS_KEY exists "${registry}" MyFirstClass)
            ct_assert_equal(exists TRUE)
        ct_end_section()

        ct_add_section("Added entry is correct")
            _cpp_class_ctor(corr MyFirstClass)
            cpp_map(GET added_class "${registry}" MyFirstClass)
            cpp_equal(result "${added_class}" "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Add class with one base class")
        _cpp_class_guts(impl_file MyFirstClass Base1)

        ct_add_section("Returns a false value")
            ct_assert_equal(impl_file FALSE)
        ct_end_section()

        ct_add_section("Now in registry")
            cpp_map(HAS_KEY exists "${registry}" MyFirstClass)
            ct_assert_equal(exists TRUE)
        ct_end_section()

        ct_add_section("Added entry is correct")
            _cpp_class_ctor(corr MyFirstClass Base1)
            cpp_map(GET added_class "${registry}" MyFirstClass)
            cpp_equal(result "${added_class}" "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Add class with two base classes")
        _cpp_class_guts(impl_file MyFirstClass Base1 Base2)

        ct_add_section("Returns a false value")
            ct_assert_equal(impl_file FALSE)
        ct_end_section()

        ct_add_section("Now in registry")
            cpp_map(HAS_KEY exists "${registry}" MyFirstClass)
            ct_assert_equal(exists TRUE)
        ct_end_section()

        ct_add_section("Added entry is correct")
            _cpp_class_ctor(corr MyFirstClass Base1 Base2)
            cpp_map(GET added_class "${registry}" MyFirstClass)
            cpp_equal(result "${added_class}" "${corr}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Returns file path if already in registry")
        _cpp_class_guts(impl_file MyFirstClass)
        _cpp_class_guts(impl_file MyFirstClass)
        ct_assert_equal(
           impl_file ${CMAKE_CURRENT_BINARY_DIR}/cpp_classes/myfirstclass.cmake
        )
    ct_end_section()
ct_end_test()
