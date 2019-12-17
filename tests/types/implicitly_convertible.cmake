include(cmake_test/cmake_test)

ct_add_test("cpp_implicitly_convertible")
    include(cmakepp_core/class/ctor)
    include(cmakepp_core/types/implicitly_convertible)

    ct_add_section("Un-related classes")
        cpp_class_ctor(Foo)
        cpp_class_ctor(Bar)
        cpp_implicitly_convertible(result Foo Bar)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Related Classes")
        cpp_class_ctor(Foo)
        cpp_class_ctor(Bar Foo)

        ct_add_section("Foo converts to obj")
            cpp_implicitly_convertible(result Foo obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Bar converts to obj")
            cpp_implicitly_convertible(result Bar obj)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Bar converts to Foo")
            cpp_implicitly_convertible(result Bar Foo)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Foo does NOT convert to Bar")
            cpp_implicitly_convertible(result Foo Bar)
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Deep Inheritance")
        cpp_class_ctor(A)
        cpp_class_ctor(B A)
        cpp_class_ctor(C B)

        ct_add_section("C converts to B")
            cpp_implicitly_convertible(result C B)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("C converts to A")
            cpp_implicitly_convertible(result C A)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("C converts to obj")
            cpp_implicitly_convertible(result C obj)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Multiple Inheritance")
        cpp_class_ctor(A)
        cpp_class_ctor(B)
        cpp_class_ctor(C A B)

        ct_add_section("Implicitly convertible to base A")
            cpp_implicitly_convertible(result C A)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Implicitly convertible to base B")
            cpp_implicitly_convertible(result C B)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Same type is okay")
        cpp_implicitly_convertible(result bool bool)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Everything is convertible to str")

        ct_add_section("bool")
            cpp_implicitly_convertible(result bool str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("float")
            cpp_implicitly_convertible(result float str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("int")
            cpp_implicitly_convertible(result int str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("list")
            cpp_implicitly_convertible(result list str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("path")
            cpp_implicitly_convertible(result path str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("target")
            cpp_implicitly_convertible(result target str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("type")
            cpp_implicitly_convertible(result type str)
            ct_assert_equal(result TRUE)
        ct_end_section()

    ct_end_section()

    ct_add_section("Different built-in types")
        cpp_implicitly_convertible(result bool double)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
