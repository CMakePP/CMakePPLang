include(cmake_test/cmake_test)

ct_add_test("_cpp_class_attr_dispatch")
    include(cmakepp_core/class/class)

    cpp_class(MyClass)
    cpp_attr(MyClass foo bar)
    MyClass(CTOR object)

    ct_add_section("Returns false if not provided 4 arguments")
        _cpp_class_attr_dispatch("${object}" result get_x)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Returns false if not get/set call")
        _cpp_class_attr_dispatch("${object}" result print)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("Can get an attribute")
        _cpp_class_attr_dispatch("${object}" result get_foo value)

        ct_add_section("Returns true")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Gets the value")
            ct_assert_equal(value bar)
        ct_end_section()
    ct_end_section()

    ct_add_section("Can set an attribute")
        _cpp_class_attr_dispatch("${object}" result set_hello world)

        ct_add_section("Returns true")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Sets value correctly")
            _cpp_class_attr_dispatch("${object}" result get_hello value)
            ct_assert_equal(value world)
        ct_end_section()
    ct_end_section()
ct_end_test()

