include(cmake_test/cmake_test)

ct_add_test("cpp_implicitly_convertible")
    include(cmakepp_core/class/class)
    include(cmakepp_core/map/map)
    include(cmakepp_core/types/implicitly_convertible)

    ct_add_section("Signature")
        cpp_implicitly_convertible(result bool str hello)
        ct_assert_fails_as("cpp_implicitly_convertible takes exactly 3 args.")
    ct_end_section()

    ct_add_section("User-defined classes")

        cpp_class(Foo)

        ct_add_section("Foo has no relatives")
            ct_add_section("Foo converts to obj")
                cpp_implicitly_convertible(result Foo obj)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("Foo not related to another class Bar")
                cpp_class(Bar)
                cpp_implicitly_convertible(result Foo Bar)
                ct_assert_equal(result FALSE)
            ct_end_section()
        ct_end_section()

        ct_add_section("Bar derives from Foo")
            cpp_class(Bar Foo)

            ct_add_section("Bar converts to Foo")
                cpp_implicitly_convertible(result Bar Foo)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("Foo does NOT convert to Bar")
                cpp_implicitly_convertible(result Foo Bar)
                ct_assert_equal(result FALSE)
            ct_end_section()
        ct_end_section()

        ct_add_section("C derives from B, which derives from A")
            cpp_class(A)
            cpp_class(B A)
            cpp_class(C B)

            ct_add_section("C converts to B")
                cpp_implicitly_convertible(result C B)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("C converts to A")
                cpp_implicitly_convertible(result C A)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("B converts to A")
                cpp_implicitly_convertible(result B A)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("A does not convert to B")
                cpp_implicitly_convertible(result A B)
                ct_assert_equal(result FALSE)
            ct_end_section()

            ct_add_section("A does not convert to C")
                cpp_implicitly_convertible(result A C)
                ct_assert_equal(result FALSE)
            ct_end_section()
        ct_end_section()

        ct_add_section("C derives from A and B")
            cpp_class(A)
            cpp_class(B)
            cpp_class(C A B)

            ct_add_section("C converts to base A")
                cpp_implicitly_convertible(result C A)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("C converts to base B")
                cpp_implicitly_convertible(result C B)
                ct_assert_equal(result TRUE)
            ct_end_section()

            ct_add_section("A does not convert to B")
                cpp_implicitly_convertible(result A B)
                ct_assert_equal(result FALSE)
            ct_end_section()

            ct_add_section("A does not convert to C")
                cpp_implicitly_convertible(result A C)
                ct_assert_equal(result FALSE)
            ct_end_section()

            ct_add_section("B does not convert to A")
                cpp_implicitly_convertible(result B A)
                ct_assert_equal(result FALSE)
            ct_end_section()

            ct_add_section("B does not convert to C")
                cpp_implicitly_convertible(result B C)
                ct_assert_equal(result FALSE)
            ct_end_section()
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

        ct_add_section("class")
            cpp_implicitly_convertible(result class str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("float")
            cpp_implicitly_convertible(result float str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("fxn")
            cpp_implicitly_convertible(result fxn str)
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

        ct_add_section("map")
            cpp_implicitly_convertible(result map str)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("object")
            cpp_implicitly_convertible(result obj str)
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

        ct_add_section("User-defined type")
            cpp_implicitly_convertible(result foo str)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Everything is convertible to list")

        ct_add_section("bool")
            cpp_implicitly_convertible(result bool list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("class")
            cpp_implicitly_convertible(result class list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("float")
            cpp_implicitly_convertible(result float list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("fxn")
            cpp_implicitly_convertible(result fxn list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("int")
            cpp_implicitly_convertible(result int list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("list")
            cpp_implicitly_convertible(result list list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("map")
            cpp_implicitly_convertible(result map list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("object")
            cpp_implicitly_convertible(result obj list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("path")
            cpp_implicitly_convertible(result path list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("target")
            cpp_implicitly_convertible(result target list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("type")
            cpp_implicitly_convertible(result type list)
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("User-defined type")
            cpp_implicitly_convertible(result foo list)
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("Class is convertible to type")
        cpp_implicitly_convertible(result class type)
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Different built-in types")
        cpp_implicitly_convertible(result bool double)
        ct_assert_equal(result FALSE)
    ct_end_section()
ct_end_test()
