include(cmake_test/cmake_test)

cpp_class(MyClass)

  # Define first implementation
  cpp_member(what_was_passed_in MyClass int)
  function("${what_was_passed_in}" self x)
      message("${x} was passed in.")
  endfunction()

  # Define second implementation
  cpp_member(what_was_passed_in MyClass int int)
  function("${what_was_passed_in}" self x y)
      message("${x} and ${y} were passed in.")
  endfunction()

cpp_end_class()

ct_add_test(NAME [[function_overloading]])
function("${CMAKETEST_TEST}")

    # Create instance of MyClass
    MyClass(CTOR my_instance)

    # Call first implementation
    MyClass(what_was_passed_in "${my_instance}" 1)

    # Outputs: 1 was passed in.

    ct_assert_prints("1 was passed in.")

    # Call second implementation
    MyClass(what_was_passed_in "${my_instance}" 2 3)

    # Outputs: 2 and 3 were passed in.

    ct_assert_prints("2 and 3 were passed in.")

endfunction()
