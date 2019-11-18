include(cmake_test/cmake_test)

ct_add_test("_cpp_get_class_registry")
    include(cmakepp_core/class/detail_/get_class_registry)

    ct_add_section("Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        _cpp_get_class_registry(TRUE)
        ct_assert_fails_as("Assertion: TRUE is desc")
    ct_end_section()

    ct_add_section("Does not already exist")
        get_property(result GLOBAL PROPERTY __CPP_CLASS_REGISTRY__)
        ct_assert_equal(result "")
    ct_end_section()

    ct_add_section("First call adds it")
        _cpp_get_class_registry(result)
        get_property(corr GLOBAL PROPERTY __CPP_CLASS_REGISTRY__)
        ct_assert_equal(result "${corr}")

        ct_add_section("Second+ calls just retrieve it")
            _cpp_get_class_registry(result)
            ct_assert_equal(result "${corr}")
        ct_end_section()
    ct_end_section()
ct_end_test()
