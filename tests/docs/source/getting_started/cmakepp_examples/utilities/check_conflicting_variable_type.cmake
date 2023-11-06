include(cmake_test/cmake_test)

ct_add_test(NAME [[check_conflicting_variable_type]])
function("${CMAKETEST_TEST}")

    set(string_to_check "target")

    # Get the type of a value and print the result
    cpp_check_conflicting_types(is_conflict conflicting_type ${string_to_check})
    message("Is there a conflict? ${is_conflict}")
    message("'${string_to_check}' conflicts with type: ${conflicting_type}")

    # Output: Is there a conflict? TRUE
    #         'target' conflicts with type: target

    ct_assert_equal(is_conflict TRUE)
    ct_assert_equal(conflicting_type "target")

endfunction()
