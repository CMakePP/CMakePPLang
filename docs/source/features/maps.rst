****
Maps
****

CMakePP provides the ``map`` type for storing key-value pairs. The CMakePP
``map`` provides the same basic functionality as C++'s ``std:map``, Python's
``dictionary``, or JavaScript's **Associative Array** structure. Users can use
maps in there code wherever they see fit. Examples of using maps are provided in
:ref:`using-maps` the section. A basic overview of the features is provided
below.

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

Setting of Values
=================

Values can be set by using the ``SET`` keyword:

.. code-block:: cmake

    # Set the value of my_key to my_value
    cpp_map(SET "${my_map}" my_key my_value)

Accessing of Values
===================

Values can be accessed using ``GET`` keyword:

.. code-block:: cmake

    # Access the value at my_key and store it in my_result
    cpp_map(GET "${my_map}" my_result my_key)
