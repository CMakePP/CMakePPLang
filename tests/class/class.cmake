include(cmake_test/cmake_test)

ct_add_test(NAME "_test_class")
function(${_test_class})
    include(cmakepp_lang/class/class)
    include(cmakepp_lang/types/types)

    ct_add_section(NAME "_class_signature" EXPECTFAIL)
    function(${_class_signature})
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        cpp_class(TRUE)
    endfunction()

    ct_add_section(NAME "_class_default")
    function(${_class_default})
        cpp_class(MyClass)
        cpp_get_global(default "myclass__state")

        ct_add_section(NAME "_class_cast_obj")
        function(${_class_cast_obj})
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_typeof")
        function(${_class_typeof})
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        endfunction()
    endfunction()

    ct_add_section(NAME "_class_conflict_w_built_in" EXPECTFAIL)
    function(${_class_conflict_w_built_in})
        cpp_class(Target)
    endfunction()

    ct_add_section(NAME "_class_base")
    function(${_class_base})
        cpp_class(BaseClass)
        cpp_class(MyClass BaseClass)

        ct_add_section(NAME "_class_base_cast")
        function(${_class_base_cast})
            cpp_implicitly_convertible(result MyClass BaseClass)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_base_cast_ptr")
        function(${_class_base_cast_ptr})
            set(myclass_ptr "MyClass")
            set(baseclass_ptr "BaseClass")
            cpp_implicitly_convertible(result myclass_ptr baseclass_ptr)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_base_cast_obj")
        function(${_class_base_cast_obj})
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_base_cast_obj")
        function(${_class_base_cast_obj})
            set(myclass_ptr MyClass)
            set(obj_ptr obj)
            cpp_implicitly_convertible(result myclass_ptr obj_ptr)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_base_typeof")
        function(${_class_base_typeof})
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        endfunction()
    endfunction()

    ct_add_section(NAME "_class_two_bases")
    function(${_class_two_bases})
        cpp_class(BaseClass1)
        cpp_class(BaseClass2)
        cpp_class(MyClass BaseClass1 BaseClass2)

        ct_add_section(NAME "_class_two_bases_cast_base1")
        function(${_class_two_bases_cast_base1})
            cpp_implicitly_convertible(result MyClass BaseClass1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_two_bases_cast_base2")
        function(${_class_two_bases_cast_base2})
            cpp_implicitly_convertible(result MyClass BaseClass2)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_two_bases_cast_obj")
        function(${_class_two_bases_cast_obj})
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_two_bases_typeof")
        function(${_class_two_bases_typeof})
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        endfunction()
    endfunction()

    ct_add_section(NAME "_class_deep")
    function(${_class_deep})
        cpp_class(BaseBaseClass)
        cpp_class(BaseClass BaseBaseClass)
        cpp_class(MyClass BaseClass)

        ct_add_section(NAME "_class_deep_base_cast_basebase")
        function(${_class_deep_base_cast_basebase})
            cpp_implicitly_convertible(result BaseClass BaseBaseClass)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_deep_myclass_cast_basebase")
        function(${_class_deep_myclass_cast_basebase})
            cpp_implicitly_convertible(result MyClass BaseBaseClass)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_deep_myclass_cast_base")
        function(${_class_deep_myclass_cast_base})
            cpp_implicitly_convertible(result MyClass BaseClass)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_deep_myclass_cast_obj")
        function(${_class_deep_myclass_cast_obj})
            cpp_implicitly_convertible(result MyClass obj)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "_class_deep_myclass_typeof")
        function(${_class_deep_myclass_typeof})
            cpp_type_of(result MyClass)
            ct_assert_equal(result class)
        endfunction()
    endfunction()
endfunction()

ct_add_test(NAME "_test_member")
function(${_test_member})
    include(cmakepp_lang/class/class)

    cpp_class(MyClass)

    ct_add_section(NAME "_member_signature")
    function(${_member_signature})
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "_member_sig_first_desc" EXPECTFAIL)
        function(${_member_sig_first_desc})
            cpp_member(TRUE MyClass)
        endfunction()

        ct_add_section(NAME "_member_sig_second_class" EXPECTFAIL)
        function(${_member_sig_second_class})
            cpp_member(a_fxn TRUE)
        endfunction()
    endfunction()

    cpp_class(MyClass)
        cpp_member(fxn_a MyClass int)
        function("${fxn_a}" self a)
            message("a = ${a}")
        endfunction()

        cpp_member(fxn_b MyClass int int)
        function("${fxn_b}" self a b)
            message("a = ${a}, b = ${b}")
        endfunction()

        cpp_member(fxn_c MyClass int desc)
        function("${fxn_c}" self a b)
            message("a = ${a}, b = ${b}")
        endfunction()

        cpp_member(fxn_d MyClass bool*)
        function("${fxn_d}" self a)
            message("a = ${a}, a dereferenced = ${${a}}")
        endfunction()

        cpp_member(fxn_e MyClass bool* bool)
        function("${fxn_e}" self a b)
            message("a = ${a}, a dereferenced = ${${a}}, b = ${b}")
        endfunction()
    cpp_end_class()

    ct_add_section(NAME "_member_single_param")
    function(${_member_single_param})
        MyClass(CTOR my_instance)
        MyClass(fxn_a "${my_instance}" 1)
        ct_assert_prints("a = 1")
    endfunction()

    ct_add_section(NAME "_member_multi_params")
    function(${_member_multi_params})
        MyClass(CTOR my_instance)
        MyClass(fxn_b "${my_instance}" 1 2)
        ct_assert_prints("a = 1, b = 2")
    endfunction()

    ct_add_section(NAME "_member_desc_params")
    function(${_member_desc_params})
        MyClass(CTOR my_instance)
        MyClass(fxn_c "${my_instance}" 1 "This is a string.")
        ct_assert_prints("a = 1, b = This is a string.")
    endfunction()

    ct_add_section(NAME "_member_bool_ptr_param")
    function(${_member_bool_ptr_param})
        MyClass(CTOR my_instance)
        set(bool_var "TRUE")
        set(bool_var_ptr bool_var)
        MyClass(fxn_d "${my_instance}" "${bool_var_ptr}")
        ct_assert_prints("a = bool_var, a dereferenced = TRUE")
    endfunction()

    ct_add_section(NAME "_member_bool_ptr_params")
    function(${_member_bool_ptr_params})
        MyClass(CTOR my_instance)
        set(bool_var "TRUE")
        set(bool_var_ptr bool_var)
        MyClass(fxn_e "${my_instance}" "${bool_var_ptr}" "${bool_var}")
        ct_assert_prints("a = bool_var, a dereferenced = TRUE, b = TRUE")
    endfunction()
endfunction()

ct_add_test(NAME "_test_virtual_member")
function(${_test_virtual_member})

    #include(cmakepp_lang/class/class)

    ct_add_section(NAME "_virt_member_sig")
    function(${_virt_member_sig})
        set(CMAKEPP_LANG_DEBUG_MODE ON)



        ct_add_section(NAME "_virt_member_sig_first_param_desc" EXPECTFAIL)
        function(${_virt_member_sig_first_param_desc})
            cpp_class(MyClass)
            cpp_virtual_member(TRUE my_virtual_fxn)
        endfunction()
    endfunction()

    macro(test_virtual_member_setup)

        # Define a base class with a virtual member
        cpp_class(BaseClass)
            cpp_member(my_virtual_fxn BaseClass)
            cpp_virtual_member(my_virtual_fxn)

            cpp_member(my_virtual_fxn_with_params BaseClass bool desc)
            cpp_virtual_member(my_virtual_fxn_with_params)

            cpp_member(my_virtual_fxn_with_ptr_params BaseClass bool* desc)
            cpp_virtual_member(my_virtual_fxn_with_ptr_params)
        cpp_end_class()

        # Define a derived class that overrides the virtual member
        cpp_class(DerivedClass BaseClass)
            cpp_member(my_virtual_fxn DerivedClass)
            function("${my_virtual_fxn}" self)
                message("Overridden implementation")
            endfunction()

            cpp_member(my_virtual_fxn_with_params DerivedClass bool desc)
            function("${my_virtual_fxn_with_params}" self a b)
                message("Overridden implementation: ${a}, ${b}")
            endfunction()

            cpp_member(my_virtual_fxn_with_ptr_params DerivedClass bool* desc)
            function("${my_virtual_fxn_with_ptr_params}" self a b)
                message("Overridden implementation: ${${a}}, ${b}")
            endfunction()
        cpp_end_class()
    endmacro()

    ct_add_section(NAME "_virt_memb_failed_call" EXPECTFAIL)
    function(${_virt_memb_failed_call})
        # Create an instance of the base class and attempt to call the virtual
        # member
        test_virtual_member_setup()
        BaseClass(CTOR base_instance)
        BaseClass(my_virtual_fxn "${base_instance}")
    endfunction()

    ct_add_section(NAME "_virt_memb_override")
    function(${_virt_memb_override})
        # Create an instance of the derived class and attempt to call the
        # implementation that overrides the virtual member
        test_virtual_member_setup()
        DerivedClass(CTOR derived_instance)
        DerivedClass(my_virtual_fxn "${derived_instance}")

        # Assert the derived implemntation was called
        ct_assert_prints("Overridden implementation")
    endfunction()

    ct_add_section(NAME "_virt_memb_override_params")
    function(${_virt_memb_override_params})
        # Create an instance of the derived class and attempt to call the
        # implementation that overrides the virtual member
        test_virtual_member_setup()
        DerivedClass(CTOR derived_instance)
        DerivedClass(my_virtual_fxn_with_params "${derived_instance}" TRUE my_desc)

        # Assert the derived implemntation was called
        ct_assert_prints("Overridden implementation: TRUE, my_desc")
    endfunction()

    ct_add_section(NAME "_virt_memb_override_ptr_params")
    function(${_virt_memb_override_ptr_params})

        set(my_ptr TRUE)
        # Create an instance of the derived class and attempt to call the
        # implementation that overrides the virtual member
        test_virtual_member_setup()
        DerivedClass(CTOR derived_instance)
        DerivedClass(my_virtual_fxn_with_ptr_params "${derived_instance}" my_ptr my_ptr)

        # Assert the derived implemntation was called
        ct_assert_prints("Overridden implementation: TRUE, my_ptr")
    endfunction()
endfunction()

ct_add_test(NAME "_test_attr")
function(${_test_attr})
    include(cmakepp_lang/class/class)

    ct_add_section(NAME "_attr_sig")
    function(${_attr_sig})
        set(CMAKEPP_LANG_DEBUG_MODE ON)


        ct_add_section(NAME "_attr_sig_first_arg_class" EXPECTFAIL)
        function(${_attr_sig_first_arg_class})
            cpp_class(MyClass)
            cpp_attr(TRUE an_attr)
        endfunction()
    endfunction()

    ct_add_section(NAME "_attr_retrieve")
    function(${_attr_retrieve})
        macro(_attr_retrieve_setup)
            # Declare class with attributes
            cpp_class(MyClass)
                cpp_attr(MyClass a 1)
                cpp_attr(MyClass b 2)
                cpp_attr(MyClass c 3)
                cpp_attr(MyClass d 4)
            cpp_end_class()

            # Create instance
            MyClass(CTOR my_instance)
        endmacro()

        ct_add_section(NAME "_retrieve_single_call")
        function(${_retrieve_single_call})
            _attr_retrieve_setup()
            MyClass(GET "${my_instance}" res_1 a)
            MyClass(GET "${my_instance}" res_2 d)
            ct_assert_equal(res_1 1)
            ct_assert_equal(res_2 4)
        endfunction()

        ct_add_section(NAME "_retrieve_multi_params_single_call")
        function(${_retrieve_multi_params_single_call})
            _attr_retrieve_setup()
            MyClass(GET "${my_instance}" res a b c d)
            ct_assert_equal(res_a 1)
            ct_assert_equal(res_b 2)
            ct_assert_equal(res_c 3)
            ct_assert_equal(res_d 4)
        endfunction()
    endfunction()

    ct_add_section(NAME "_attr_set")
    function(${_attr_set})
        macro(_attr_set_setup)
            # Declare class with attributes
            cpp_class(MyClass)
                cpp_attr(MyClass a 1)
                cpp_attr(MyClass b 2)
            cpp_end_class()

            # Create instance
            MyClass(CTOR my_instance)
       endmacro()

        ct_add_section(NAME "_attr_set_single_val")
        function(${_attr_set_single_val})
            _attr_set_setup()
            # Set attribute as single value
            MyClass(SET "${my_instance}" a 3)
            # Get the value and ensure it was set correctly
            MyClass(GET "${my_instance}" res a)
            ct_assert_equal(res 3)
        endfunction()

        ct_add_section(NAME "_attr_set_list")
        function(${_attr_set_list})
            _attr_set_setup()

            # Set attribute as a list of values
            MyClass(SET "${my_instance}" b 1 2 3)
            # Get the value and ensure it was set correctly
            MyClass(GET "${my_instance}" res b)
            ct_assert_equal(res "1;2;3")
        endfunction()

    endfunction()
endfunction()

ct_add_test(NAME "_test_constructor")
function(${_test_constructor})
    include(cmakepp_lang/class/class)

    ct_add_section(NAME "_test_constructor_sig")
    function(${_test_constructor_sig})
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "_constructor_sig_first_arg_desc" EXPECTFAIL)
        function(${_constructor_sig_first_arg_desc})
            cpp_constructor(TRUE Myclass)
        endfunction()

        ct_add_section(NAME "_constructor_sig_second_arg_class" EXPECTFAIL)
        function(${_constructor_sig_second_arg_class})
            cpp_constructor(a_fxn TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "_constructor_no_custom_found")
    function(${_constructor_no_custom_found})
        # Define class with no CTOR
        cpp_class(MyClass)
            cpp_attr(MyClass my_attr 1)
        cpp_end_class()

        # Create instance
        MyClass(CTOR my_instance)
        MyClass(GET "${my_instance}" res my_attr)
        ct_assert_equal(res 1)
    endfunction()

    ct_add_section(NAME "_constructor_single_custom")
    function(${_constructor_single_custom})
        # Define class with one custom CTOR
        cpp_class(MyClass)
            cpp_attr(MyClass my_attr 1)

            cpp_constructor(CTOR MyClass)
            function("${CTOR}" self)
                MyClass(SET "${self}" my_attr 2)
            endfunction()
        cpp_end_class()

        # Create instance and test that the custom CTOR was called
        MyClass(CTOR my_instance)
        MyClass(GET "${my_instance}" res my_attr)
        ct_assert_equal(res 2)
    endfunction()

    ct_add_section(NAME "_constructor_multiple_customs")
    function(${_constructor_multiple_customs})
        macro(_constructor_multiple_customs_setup)

            # Define class with multiple cuustom CTORs
            cpp_class(MyClass)
                cpp_attr(MyClass my_attr 1)

                cpp_constructor(CTOR MyClass)
                function("${CTOR}" self)
                    # Change value of my_attr
                    MyClass(SET "${self}" my_attr 2)
                endfunction()

                cpp_constructor(CTOR MyClass int)
                function("${CTOR}" self a)
                    # Change value of my_attr
                    MyClass(SET "${self}" my_attr "${a}")
                endfunction()
            cpp_end_class()
        endmacro()

        ct_add_section(NAME "_multi_construct_first_no_params")
        function(${_multi_construct_first_no_params})
            _constructor_multiple_customs_setup()
            # Create instance and test that the 1st CTOR was called
            MyClass(CTOR my_instance)
            MyClass(GET "${my_instance}" res my_attr)
            ct_assert_equal(res 2)
        endfunction()

        ct_add_section(NAME "_multi_construct_second_int_param")
        function(${_multi_construct_second_int_param})
            _constructor_multiple_customs_setup()
            # Create instance and test that the 1st CTOR was called
            MyClass(CTOR my_instance 3)
            MyClass(GET "${my_instance}" res my_attr)
            ct_assert_equal(res 3)
        endfunction()

    endfunction()

    ct_add_section(NAME "_construct_kwargs")
    function(${_construct_kwargs})

        macro(_construct_kwargs_setup)
            # Define class with three attributes
            cpp_class(MyClass)
                cpp_attr(MyClass a 10)
                cpp_attr(MyClass b 20)
                cpp_attr(MyClass c 30)
            cpp_end_class()
        endmacro()

        ct_add_section(NAME "_kwargs_sets_attr")
        function(${_kwargs_sets_attr})
            _construct_kwargs_setup()
            # Create instance using KWARGS CTOR and call MyFunc
            MyClass(CTOR my_instance KWARGS a 1 b 2 3 4 c 5 6)
            MyClass(GET "${my_instance}" res a b c)
            ct_assert_equal(res_a 1)
            ct_assert_equal(res_b "2;3;4")
            ct_assert_equal(res_c "5;6")
        endfunction()

        ct_add_section(NAME "_kwargs_first_not_attr" EXPECTFAIL)
        function(${_kwargs_first_not_attr})
            _construct_kwargs_setup()
            MyClass(CTOR my_instance KWARGS not_an_attr 1 b 2 3 4 c 5 6)
        endfunction()
    endfunction()

    ct_add_section(NAME "_construct_call_base")
    function(${_construct_call_base})
        # Define ParentClass
        cpp_class(ParentClass)
            cpp_attr(ParentClass parent_attr a)

            cpp_constructor(CTOR ParentClass)
            function("${CTOR}" self)
                # Change value of parent_attr
                ParentClass(SET "${self}" parent_attr b)
            endfunction()
        cpp_end_class()

        # Define DerivedClass
        cpp_class(DerivedClass ParentClass)
            cpp_attr(DerivedClass derived_attr 1)

            cpp_constructor(CTOR DerivedClass)
            function("${CTOR}" self)
                # Call CTOR of ParentClass
                ParentClass(CTOR "${self}")
                # Change value of derived_attr
                DerivedClass(SET "${self}" derived_attr 2)
            endfunction()

            cpp_member(MyFunc DerivedClass)
            function("${MyFunc}" self)
                DerivedClass(GET "${self}" p_attr parent_attr)
                DerivedClass(GET "${self}" d_attr derived_attr)
                message("parent_attr = ${p_attr}, derived_attr = ${d_attr}")
            endfunction()
        cpp_end_class()

        # Create instance
        DerivedClass(CTOR my_instance)
        # Test that both derived and parent CTORs were called
        DerivedClass(GET "${my_instance}" p_attr parent_attr)
        DerivedClass(GET "${my_instance}" d_attr derived_attr)
        ct_assert_equal(p_attr b)
        ct_assert_equal(d_attr 2)
    endfunction()

    ct_add_section(NAME "_construct_no_overload" EXPECTFAIL)
    function(${_construct_no_overload})
        # Define MyClass
        cpp_class(MyClass)
        cpp_end_class()

        # Call CTOR with args passed
        MyClass(CTOR my_instance 1 2 3)
    endfunction()

    ct_add_section(NAME "_construct_call_non_parent_ctor" EXPECTFAIL)
    function(${_construct_call_non_parent_ctor})
        # Create classes with inheritance
        cpp_class(ParentClass)
            cpp_constructor(CTOR ParentClass)
            function("${CTOR}" self)
            endfunction()
        cpp_end_class()

        cpp_class(NonParentClass)
            cpp_constructor(CTOR NonParentClass)
            function("${CTOR}" self)
            endfunction()
        cpp_end_class()

        cpp_class(DerivedClass ParentClass)
            cpp_constructor(CTOR DerivedClass)
            function("${CTOR}" self)
                NonParentClass(CTOR "${self}")
            endfunction()
        cpp_end_class()

        # Call CTOR
        DerivedClass(CTOR my_instance)
    endfunction()

endfunction()
