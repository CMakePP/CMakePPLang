include(cmake_test/cmake_test)

ct_add_test("_cpp_class_write_wrapper")
    include(cmakepp_core/class/class)

    cpp_class_ctor(MyClass)
    _cpp_class_write_wrapper(MyClass file_path)

    ct_add_section("Returns the correct path")
        set(
            corr_file
            "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/classes/myclass.cmake"
        )
        ct_assert_equal(file_path "${corr_file}")
    ct_end_section()

    ct_add_section("File exists")
        include(cmakepp_core/utilities/file_exists)
        cpp_file_exists(result "${file_path}")
        ct_assert_equal(result TRUE)
    ct_end_section()

ct_end_test()
