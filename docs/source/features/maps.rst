****
Maps
****

CMakePP provides the ``map`` type for storing key-value pairs. The CMakePP
``map`` provides the same basic functionality as Python's **dictionary**
structure and JavaScript's **associative array** structure. Users can use maps
in there code wherever they see fit. Examples of using maps are provided in
:ref:`using-maps` the section. A basic overview of the features is provided
below.

Map Creation
============

The map constructor ``cpp_map(CTOR my_map)`` is used to create an empty map with
the name ``my_map``. Optionally, key-value pairs can be provided to the map
constructor. You must simply add keys and their corresponding values as
arguments passed to the constructor:
``cpp_map(CTOR my_map key_a value_a key_b value_b)``. These initial key-value
pairs will be added to the map upon to construction.

Setting of Values
=================

Values can be set by using ``cpp_map(SET "${my_map}" my_key my_value)`` where
``my_map`` is the map you want to modify, ``my_key`` is the key of the key-value
pair you want to add, and ``my_value`` is the value of that key-value pair.

Accessing of Values
===================

Values can be accessed using ``cpp_map(GET "${my_map}" my_result my_key)`` where
``my_map`` is the map containing the value you want to access, ``my_result`` is
the name of the variable you want to store the resulting value in, and
``my_key`` is the key of the value you want to access.
