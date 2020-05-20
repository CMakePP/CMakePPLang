.. _using-utilities:

***************
Using Utilities
***************

This page provides examples of using CMakePP's utility functions.

Checking if Variables are Equal
===============================

We can use the ``cpp_equal`` function to check for equality between any two
variables, including objects and maps.

.. code-block:: cmake

  # Create three strings, two that are equivalent and on that is not
  set(string_a "Hello World")
  set(string_b "Hello World")
  set(string_c "Goodbye World")

  # Check if certain strings are equivalent
  cpp_equal(result_ab "${string_a}" "${string_b}")
  cpp_equal(result_ac "${string_a}" "${string_c}")

  # Print out the results
  message("A equals B? ${result_ab}")
  message("A equals C? ${result_ac}")

  # Output:
  # A equals B? TRUE
  # A equals C? FALSE

.. note::

  For native CMake types, such as booleans and integers, equality is defined as
  being the same string.

Serializing a Variable
======================

We can use ``cpp_serialize`` to serialize a variable into a JSON string:

.. code-block:: cmake

  # Create a map containing a desc
  cpp_map(CTOR my_map desc_key "Hello World")

  # Create a list and it to the map
  set(my_list 1 2 3)
  cpp_map(SET "${my_map}" list_key "${my_list}")

  # Serialize the map and print out the result
  cpp_serialize(serialized "${my_map}")
  message("${serialized}")

  # Output:
  # { "desc_key" : "Hello World", "list_key" : [ "1", "2", "3" ] }

Copying a Variable
==================

We can use the ``cpp_copy`` to create a deep copy of an existing variable
regardless of what type it is:

.. code-block:: cmake

  # Create a list
  set(my_list 1 2 3)

  # Create a map containing a desc and a list
  cpp_map(CTOR my_map desc_key "desc" list_key "${my_list}")

  # Create a copy of the map
  cpp_copy(map_copy "${my_map}")

  # Serialize the copy and print out the result
  cpp_serialize(serialized map_copy)
  message("${serialized}")

  # Output:
  # { "desc_key" : "Hello World", "list_key" : [ "1", "2", "3" ] }

Checking if Variable Contains a Value
=====================================

We can use the ``cpp_contains`` function to check if a certain value is
contained within another variable. The behavior changes depending on the type of
the variable we are examining.

Check if a Desc Contains a Substring
------------------------------------

We can use ``cpp_contains`` to check if a desc contains a substring:

.. code-block:: cmake

  # Create a desc
  set(my_desc "Here is a desc")

  # Check if the desc contains certain substrings
  cpp_contains(desc_has_here "Here" "${my_desc}")
  cpp_contains(desc_has_a "a" "${my_desc}")
  cpp_contains(desc_has_foo "foo" "${my_desc}")

  # Print out the results
  message("Desc contains \"Here\"? ${desc_has_here}")
  message("Desc contains \"a\"? ${desc_has_a}")
  message("Desc contains \"foo\"? ${desc_has_foo}")

  # Output:
  # Desc contains "Here"? TRUE
  # Desc contains "a"? TRUE
  # Desc contains "foo"? FALSE

Check if a List Contains a Value
--------------------------------

We can use ``cpp_contains`` to check if a list contains a value:

.. code-block:: cmake

  # Create list containing some values
  set(my_list 1 2 3 "hello" "world")

  # Check if the list contains certain values
  cpp_contains(list_has_two 2 "${my_list}")
  cpp_contains(list_has_hello "hello" "${my_list}")
  cpp_contains(list_has_foo "foo" "${my_list}")

  # Print out the results
  message("List contains 2? ${list_has_two}")
  message("List contains \"hello\"? ${list_has_hello}")
  message("List contains \"foo\"? ${list_has_foo}")

  # Output:
  # List contains 2? TRUE
  # List contains "hello"? TRUE
  # List contains "foo"? FALSE

.. note::

  ``cpp_contains`` can take CMakePP objects and maps as search values.

Check if a Map Contains a Key
-----------------------------

We can use ``cpp_contains`` to check if a map contains a key:

.. code-block:: cmake

  # Create a map containing some initial key value pairs
  cpp_map(CTOR my_map key_a value_a key_b value_b)

  # Check if the map contains a certain keys
  cpp_contains(map_has_key_a key_a "${my_map}")
  cpp_contains(map_has_key_c key_c "${my_map}")

  # Print out the results
  message("Map contains key_a? ${map_has_key_a}")
  message("Map contains key_c? ${map_has_key_c}")

  # Output:
  # Map contains key_a? TRUE
  # Map contains key_c? FALSE

Determining the Type of a Variable
==================================

We can use ``cpp_type_of`` to get the type of a variable or value:

.. code-block:: cmake

  # Get the type of a value and print the result
  cpp_type_of(result TRUE)
  message("${result}")

  # Output: bool

.. note::

  ``cpp_type_of`` works with CMakePP types as well as native CMake types.

Asserting a Condition
=====================

We can use ``cpp_assert`` to assert that a given value is true:

.. code-block:: cmake

  # Assert that 3 is an int
  cpp_is_int(is_int 3)
  cpp_assert("${_is_int}" "3 is an integer")

  # Assert that x is greater than 3
  set(x 4)
  cpp_assert("${x};GREATER;3" "x is > 3")

If an assert fails, it will stop the execution of the program and print the
provided assertion message along with the call stack from where the assertion
failed.

Checking if a File Exists
=========================

We can use ``cpp_file_exists`` to check if files exist:

.. code-block:: cmake

  # Check if some files exist
  cpp_file_exists(result_1 "/home/joe/file_that_exists.txt")
  cpp_file_exists(result_2 "/home/joe/file_that_does_not_exists.txt")

  # Call the function and pass in directory
  cpp_file_exists(result_3 "/home/joe/Desktop")

  message("${result_1}")        # Output: TRUE
  message("${result_2}")        # Output: FALSE
  message("${result_3}")        # Output: FALSE

  # Output:
  # TRUE
  # TRUE
  # FALSE

Manipulating Globals
====================

We can use ``cpp_set_global``, ``cpp_get_global``, and ``cpp_append_global`` to
get, set, and append global values:

.. code-block:: cmake

  # Set a global value
  cpp_set_global(key_a "Hello")

  # Get the global value and print it out
  cpp_get_global(result_a key_a)
  message("${result_a}")

  # Output: Hello

  # Append the global value
  cpp_append_global(key_a " World")

  # Get the global value and print it out again
  cpp_get_global(result_a key_a)
  message("${result_a}")

  # Output: Hello World

Creating a Unique Identifier
============================

We can use ``cpp_unique_id`` to create a unique identifier:

.. code-block:: cmake

  # Create a unique ID and print it out
  cpp_unique_id(new_uid)
  message("${new_uid}")

  # Outputs something like: 9ii6l_1581033874
