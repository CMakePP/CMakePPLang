****
Maps
****

The CMakePP language provides the ``map`` type for storing key-value pairs. 
The CMakePP ``map`` provides the same basic functionality as C++'s 
``std::map``, Python's ``dictionary``, or JavaScript's **Associative Array** 
structure. Users can use maps in there code wherever they see fit. A basic 
overview of the features is provided below.

Map Creation
============

The map constructor is used to create an empty map:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 6-7
   :dedent:

Optionally, key-value pairs can be provided to the map constructor. You must
simply add keys and their corresponding values as arguments passed to the
constructor:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 9-10
   :dedent:

Setting Values
==============

Values can be set by using the ``SET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 12-13
   :dedent:

Accessing Values
================

Values can be accessed using ``GET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 15-19
   :dedent:

Appending Values
================

Values can be appended by using the ``APPEND`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 23-24
   :dedent:

Copying a Map
=============

Maps can be copied using the ``COPY`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 32-33
   :dedent:

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
