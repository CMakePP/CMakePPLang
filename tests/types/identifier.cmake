include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_identifier")
function("${test_cpp_is_identifier}")
    include(cmakepp_lang/types/identifier)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        cpp_is_identifier(return TRUE hello)
    endfunction()

    # All booleans are identifiers, including
    # the *-notfound values
    ct_add_section(NAME "test_bool")
    function("${test_bool}")
        ct_add_section(NAME "case_insens")
        function("${case_insens}")
            cpp_is_identifier(return TrUe)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_ON")
        function("${val_ON}")
            cpp_is_identifier(return ON)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_YES")
        function("${val_YES}")
            cpp_is_identifier(return YES)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_TRUE")
        function("${val_TRUE}")
            cpp_is_identifier(return TRUE)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_Y")
        function("${val_Y}")
            cpp_is_identifier(return Y)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_OFF")
        function("${val_OFF}")
            cpp_is_identifier(return OFF)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_NO")
        function("${val_NO}")
            cpp_is_identifier(return NO)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_FALSE")
        function("${val_FALSE}")
            cpp_is_identifier(return FALSE)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_N")
        function("${val_N}")
            cpp_is_identifier(return N)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_IGNORE")
        function("${val_IGNORE}")
            cpp_is_identifier(return IGNORE)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_NOTFOUND")
        function("${val_NOTFOUND}")
            cpp_is_identifier(return NOTFOUND)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "val_end_NOTFOUND")
        function("${val_end_NOTFOUND}")
            cpp_is_identifier(return hello-notfound)
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()  # add_section(bool)

    # A class name must be an identifier
    ct_add_section(NAME "test_class")
    function("${test_class}")
        include(cmakepp_lang/class/class)
        cpp_class(MyClass)

        cpp_is_identifier(return MyClass)
        ct_assert_equal(return TRUE)
    endfunction()

    # Commands are identifiers
    ct_add_section(NAME "test_command")
    function("${test_command}")
        cpp_is_identifier(return add_subdirectory)
        ct_assert_equal(return TRUE)
    endfunction()

    # Descriptions can be identifiers, but do not have to be
    ct_add_section(NAME "descriptions")
    function("${descriptions}")
        # Cannot have a space in an identifier that is not escaped
        ct_add_section(NAME "description_with_spaces")
        function("${description_with_spaces}")
            cpp_is_identifier(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description_with_multi_spaces")
        function("${description_with_multi_spaces}")
            cpp_is_identifier(return "Hello World TRUE")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description_with_leading_space")
        function("${description_with_leading_space}")
            cpp_is_identifier(return " TRUE")
            ct_assert_equal(return FALSE)
        endfunction()

        # Spaces are allowed so long as they are escaped
        # Here we need a bracket argument
        # because escaping the space in a quoted
        # argument consumes the slash even though it doesn't
        # do anything with the escaped space. Presumably
        # this is why setting a variable with the name "a var"
        # or "a\ var" results in referencing the same variable.
        ct_add_section(NAME "description_with_escaped_spaces")
        function("${description_with_escaped_spaces}")
            cpp_is_identifier(return [[hello\ world]])
            ct_assert_equal(return TRUE)
        endfunction()

        # Yes, that means you can have a variable that is only
        # a single escaped space.
        ct_add_section(NAME "description_with_only_escaped_space")
        function("${description_with_only_escaped_space}")
            cpp_is_identifier(return [[\ ]])
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "description_with_hyphens")
        function("${description_with_hyphens}")
            cpp_is_identifier(return "hello-world")
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "description_with_underscores")
        function("${description_with_underscores}")
            cpp_is_identifier(return "hello_world")
            ct_assert_equal(return TRUE)
        endfunction()

        # Numbers are alllowed
        ct_add_section(NAME "description_with_numbers")
        function("${description_with_numbers}")
            cpp_is_identifier(return "hello_world2")
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

    # Identifiers can include both numbers and dots
    ct_add_section(NAME "test_float")
    function("${test_float}")
        cpp_is_identifier(return 3.14)
        ct_assert_equal(return TRUE)
    endfunction()

    # Identifiers can include numbers
    ct_add_section(NAME "test_integer")
    function("${test_integer}")
        ct_add_section(NAME "int_one")
        function("${int_one}")
            cpp_is_identifier(return 1)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "int_zero")
        function("${int_zero}")
            cpp_is_identifier(return 0)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "int_42")
        function("${int_42}")
            cpp_is_identifier(return 42)
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

    # Lists are not valid identifiers because of the semicolon,
    # and the semicolon cannot be escaped
    ct_add_section(NAME "test_list")
    function("${test_list}")
        ct_add_section(NAME "normal_list")
        function("${normal_list}")
            cpp_is_identifier(return "1;2;3")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "list_with_bool_literals")
        function("${list_with_bool_literals}")
            cpp_is_identifier(return "TRUE;FALSE")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    # Maps can be identifiers, but do not have to be
    ct_add_section(NAME "test_map")
    function("${test_map}")
        ct_add_section(NAME "map_with_identifier_name")
        function("${map_with_identifier_name}")
            include(cmakepp_lang/map/map)
            cpp_map(CTOR a_map)
            cpp_is_identifier(result a_map)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "map_with_non_identifier_name")
        function("${map_with_non_identifier_name}")
            include(cmakepp_lang/map/map)
            cpp_map(CTOR "a map")
            cpp_is_identifier(result "a map")
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    # While CMake variables do allow slashes in their names,
    # it would cause confusion as to whether some string
    # is an identifier or a path. Thus, we do not allow
    # identifiers with slashes
    ct_add_section(NAME "test_path")
    function("${test_path}")

        ct_add_section(NAME "some_path")
        function("${some_path}")
            cpp_is_identifier(return "${CMAKE_CURRENT_LIST_DIR}/a_path")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    # Targets are assumed to be valid identifiers
    ct_add_section(NAME "test_target")
    function("${test_target}")
        ct_add_section(NAME "normal_target_name")
        function("${normal_target_name}")
            add_library(lib STATIC IMPORTED)
            cpp_is_identifier(return lib)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "target_name_contains_bool")
        function("${target_name_contains_bool}")
            add_library(libTRUE STATIC IMPORTED)
            cpp_is_identifier(return libTRUE)
            ct_assert_equal(return TRUE)
        endfunction()
    endfunction()

    # A type can be an identifier, but isn't necessarily
    # always one
    ct_add_section(NAME "test_type")
    function("${test_type}")
        ct_add_section(NAME "raw_type")
        function("${raw_type}")
            cpp_is_identifier(return bool)
            ct_assert_equal(return TRUE)
        endfunction()

        ct_add_section(NAME "pointer_type")
        function("${pointer_type}")
            cpp_is_identifier(return bool*)
            ct_assert_equal(return FALSE)
        endfunction()

    endfunction()
endfunction()
