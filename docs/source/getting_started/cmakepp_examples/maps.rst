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
