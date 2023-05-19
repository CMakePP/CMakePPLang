.. Copyright 2023 CMakePP
..
.. Licensed under the Apache License, Version 2.0 (the "License");
.. you may not use this file except in compliance with the License.
.. You may obtain a copy of the License at
..
.. http://www.apache.org/licenses/LICENSE-2.0
..
.. Unless required by applicable law or agreed to in writing, software
.. distributed under the License is distributed on an "AS IS" BASIS,
.. WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
.. See the License for the specific language governing permissions and
.. limitations under the License.

*********
Utilities
*********

CMakePPLang provides the following utility commands:

- ``cpp_equal`` for checking for equality between two variables
- ``cpp_serialize`` for serializing a variable into a JSON string
- ``cpp_copy`` for creating a copy of a variable
- ``cpp_contains`` for checking if a string contains a certain substring, a list
  contains a certain item, or a map contains a certain key
- ``cpp_type_of`` for determining the type of a variable
- ``cpp_check_conflicting_types`` for checking if a string conflicts with a :ref:`built-in type <features-types>`
- ``cpp_return`` for returning values from a function
- ``cpp_assert`` for asserting that a condition is true and stopping the
  build process if that condition is not true
- ``cpp_directory_exists`` for checking that a directory at a given path
  exists and is directory, not a file
- ``cpp_file_exists`` for checking that a file at a given path exists and is
  in fact a file and not a directory
- ``cpp_set_global`` for setting the value of a global variable
- ``cpp_get_global`` for getting the value of a global variable
- ``cpp_append_global`` for appending a value to a global variable
- ``cpp_unique_id`` for creating a unique identifier

Examples of using these functions can be found :ref:`examples-utilities`.
