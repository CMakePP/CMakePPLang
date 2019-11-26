include(cmake_test/cmake_test)

ct_add_test("_cpp_assert_class_is_registered")
    include(cmakepp_core/class/class)
    set(CMAKEPP_CORE_DEBUG_MODE ON)
    ct_add_section("Does not crash if class is registered.")
        cpp_class(MyClass)
        _cpp_assert_class_is_registered(MyClass)
    ct_end_section()

    ct_add_section("Fails if type has not been registered")
        _cpp_assert_class_is_registered(NotAClass)
        ct_assert_fails_as("Can not retrieve member functions for type:")
    ct_end_section()

ct_end_test()
