*********
Utilities
*********

The CMakePP language provides the following utility commands:

- ``cpp_equal`` for checking for equality between two variables
- ``cpp_serialize`` for serializing a variable into a JSON string
- ``cpp_copy`` for creating a copy of a variable
- ``cpp_contains`` for checking if a string contains a certain substring, a list
  contains a certain item, or a map contains a certain key
- ``cpp_type_of`` for determining the type of a variable
- ``cpp_assert`` for asserting that a condition is true and stopping the
  build process if that condition is not true
- ``cpp_file_exists`` for checking that a file at a given path exists and is
  in fact a fie and not a directory
- ``cpp_set_global`` for setting the value of a global variable
- ``cpp_get_global`` for getting the value of a global variable
- ``cpp_append_global`` for appending a value to a global variable
- ``cpp_unique_id`` for creating a unique identifier

Examples of using these functions can be found :ref:`examples-utilities`.
