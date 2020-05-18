.. _using-maps:

**********
Using Maps
**********

This page provides examples of using CMakePP maps.

Creating an Empty Map
=====================

We can construct a map with no initial key-value pairs using the following code:

.. code-block:: cmake

  # Construct an empty map called "my_map"
  cpp_map(CTOR my_map)

Storing and Accessing Values
============================

We can then store new values and access those values using the following code:

.. code-block:: cmake

  # Set some new values
  cpp_map(SET "${my_map}" key_a value_a)
  cpp_map(SET "${my_map}" key_b value_b)

  # Access the values and store them in "result_a" and "result_b"
  cpp_map(GET "${my_map}" result_a key_a)
  cpp_map(GET "${my_map}" result_b key_b)

  # Print the values out
  message("result_a: ${result_a}")
  message("result_b: ${result_b}")

  # Output:
  # result_a: value_a
  # result_b: value_b

Creating a Map with Initial Values
==================================

We can also create a map with initial values by passing key-value pairs to the
constructor in the following way:

.. code-block:: cmake

  # Construct a map with initial key value pairs:
  # [key_a->value_a, key_b->value_b]
  cpp_map(CTOR my_map key_a value_a key_b value_b)

  # Access the values and store them in "result_a" and "result_b"
  cpp_map(GET "${my_map}" result_a key_a)
  cpp_map(GET "${my_map}" result_b key_b)

  # Print the values out
  message("result_a: ${result_a}")
  message("result_b: ${result_b}")

  # Output:
  # result_a: value_a
  # result_b: value_b

Appending Values
================

We can append values to an existing value using the ``APPEND`` keyword:

.. code-block:: cmake

  # Append new_value to the value at my_key
  cpp_map(APPEND "${my_map}" my_key new_value)

Copying a Map
=============

We can copy a map using the ``COPY`` keyword:

.. code-block:: cmake

  # Copy my_map to my_map_copy
  cpp_map(COPY "${my_map}" my_map_copy)

Checking Equality of Maps
=========================

We can check for equality between maps using the ``EQUAL`` keyword:

.. code-block:: cmake

  # Check if map_a is equivalent to map_b
  cpp_map(EQUAL "${map_a}" equal_result "${map_b}")

Checking if a Map has a Key
===========================

We can check whether a map contains a key with the ``HAS_KEY`` keyword:

.. code-block:: cmake

  # Check whether the map has the key "my_key"
  cpp_map(HAS_KEY "${my_map}" has_key_result my_key)

Getting a Map's Keys
====================

We can get a list of a map's keys using the ``KEYS`` keyword:

.. code-block:: cmake

  # Put the list of the map's keys in keys_list
  cpp_map(KEYS "${my_map}" keys_list)
