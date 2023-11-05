include(cmake_test/cmake_test)

ct_add_test(NAME [[serialization]])
function("${CMAKETEST_TEST}")

    ct_add_section(NAME [[serialize_map]])
    function("${CMAKETEST_SECTION}")
        # Create a map with initial key value pairs
        cpp_map(CTOR my_map "key_a" "value_a" "key_b" "value_b")

        # Serialize the map
        cpp_serialize(my_map_serialized "${my_map}")

        # ${my_map_serialized} = { "key_a": "value_a", "key_b": "value_b" }

        ct_assert_equal(
            my_map_serialized 
            "{ \"key_a\" : \"value_a\", \"key_b\" : \"value_b\" }"
        )
    endfunction()

    ct_add_section(NAME [[serialize_list]])
    function("${CMAKETEST_SECTION}")
        # Create a list
        set(my_list "this;is;a;list")

        # Serialize the list
        cpp_serialize(my_list_serialized "${my_list}")

        # ${my_list_serialized} = [ "this", "is", "a", "list" ]

        ct_assert_equal(
            my_list_serialized 
            "[ \"this\", \"is\", \"a\", \"list\" ]"
        )
    endfunction()

    ct_add_section(NAME [[serialize_object]])
    function("${CMAKETEST_SECTION}")
        cpp_class(Automobile)

            cpp_attr(Automobile color red)
            cpp_attr(Automobile num_doors 4)

            cpp_member(start Automobile)
            function("${start}" self)
                set(result "Vroom! I have started my engine." PARENT_SCOPE)
            endfunction()

            cpp_member(start Automobile int)
            function("${start}" self distance_km)
                set(result "Vroom! I started my engine and I just drove ${distance_km} km!" PARENT_SCOPE)
            endfunction()

            cpp_member(drive Automobile int str)
            function("${drive}" self distance_km destination)
                set(result "I just drove ${distance_km} km to ${destination}!" PARENT_SCOPE)
            endfunction()

        cpp_end_class()

        Automobile(CTOR my_inst)

        cpp_serialize(my_obj_serialized "${my_inst}")
    endfunction()

endfunction()
