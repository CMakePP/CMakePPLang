****
Maps
****

CMakePP provides the ``map`` type for storing key-value pairs. The CMakePP
``map`` provides the same basic functionality as C++'s ``std:map``, Python's
``dictionary``, or JavaScript's **Associative Array** structure. Users can use
maps in there code wherever they see fit. A basic overview of the features is
provided below.

Map Creation
============

The map constructor is used to create an empty map:

.. code-block:: cmake

  # Create an empty map named my_map
  cpp_map(CTOR my_map)

Optionally, key-value pairs can be provided to the map constructor. You must
simply add keys and their corresponding values as arguments passed to the
constructor:

.. code-block:: cmake

  # Create a map with initial key value pairs
  cpp_map(CTOR my_map key_a value_a key_b value_b)

Accessing Values
================

Values can be accessed using ``GET`` keyword:

.. code-block:: cmake

    # Access the value at my_key and store it in my_result
    cpp_map(GET "${my_map}" my_result my_key)

Setting Values
==============

Values can be set by using the ``SET`` keyword:

.. code-block:: cmake

    # Set the value of my_key to my_value
    cpp_map(SET "${my_map}" my_key my_value)

Appending Values
================

Values can be appended by using the ``APPEND`` keyword:

.. code-block:: cmake

    # Append new_value to the value at my_key
    cpp_map(APPEND "${my_map}" my_key new_value)

Copying a Map
=============

Maps can be copied using the ``COPY`` keyword:

.. code-block:: cmake

    # Copy my_map to my_map_copy
    cpp_map(COPY "${my_map}" my_map_copy)

Checking Equality of Maps
=========================

Map equality can be checked using the ``EQUAL`` keyword:

.. code-block:: cmake

    # Check if map_a is equivalent to map_b
    cpp_map(EQUAL "${map_a}" equal_result "${map_b}")

Checking if a Map has a Key
===========================

Check whether the map contains a key with the ``HAS_KEY`` keyword:

.. code-block:: cmake

    # Check whether the map has the key "my_key"
    cpp_map(HAS_KEY "${my_map}" has_key_result my_key)

Getting a Map's Keys
====================

A list of a map's keys can be retrieved using the ``KEYS`` keyword:

.. code-block:: cmake

    # Put the list of the map's keys in keys_list
    cpp_map(KEYS "${my_map}" keys_list)
