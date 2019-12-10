include(cmake_test/cmake_test)

ct_add_test("cpp_function")
    include(cmakepp_core/function/function)

    ct_add_section("Only one overload")

        ct_add_section("Returns the mangled name")
            cpp_function(a_fxn int bool)
            _cpp_mangle_fxn(result a_fxn int bool)
            ct_assert_equal(result "${a_fxn}")
        ct_end_section()

        ct_add_section("Creates implementation file")
            cpp_function(a_fxn int bool)
            include(cmakepp_core/utilities/file_exists)
            cpp_file_exists(
                result "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxns/a_fxn.cmake"
            )
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("a_fxn is in scope")
            cpp_function(a_fxn int bool)
            if(NOT COMMAND "a_fxn")
                message(FATAL_ERROR "a_fxn is not an envokable command.")
            endif()
        ct_end_section()
    ct_end_section()

    ct_add_section("Two overloads")
        cpp_function(a_fxn)
        set(mn1 ${a_fxn})

        cpp_function(a_fxn desc)
        set(mn2 ${a_fxn})

        ct_add_section("Returns mangled names")
            _cpp_mangle_fxn(corr1 a_fxn)
            ct_assert_equal(mn1 "${corr1}")
            _cpp_mangle_fxn(corr2 a_fxn desc)
            ct_assert_equal(mn2 "${corr2}")
        ct_end_section()

        ct_add_section("Creates implementation file")
            include(cmakepp_core/utilities/file_exists)
            cpp_file_exists(
                result "${CMAKE_CURRENT_BINARY_DIR}/cmakepp/fxns/a_fxn.cmake"
            )
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("a_fxn is in scope")
            if(NOT COMMAND "a_fxn")
                message(FATAL_ERROR "a_fxn is not an envokable command.")
            endif()
        ct_end_section()
    ct_end_section()
ct_end_test()
