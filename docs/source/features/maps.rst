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
   :lines: 11-12
   :dedent:

Optionally, key-value pairs can be provided to the map constructor. You must
simply add keys and their corresponding values as arguments passed to the
constructor:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 14-15
   :dedent:

Setting Values
==============

Values can be set by using the ``SET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 17-18
   :dedent:

Accessing Values
================

Values can be accessed using ``GET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 20-21
   :dedent:

Appending Values
================

Values can be appended by using the ``APPEND`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 25-26
   :dedent:

Copying a Map
=============

Maps can be copied using the ``COPY`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 34-35
   :dedent:

Checking Equality of Maps
=========================

Map equality can be checked using the ``EQUAL`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 37-38
   :dedent:

Checking if a Map has a Key
===========================

Check whether the map contains a key with the ``HAS_KEY`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 42-43
   :dedent:

Getting a Map's Keys
====================

A list of a map's keys can be retrieved using the ``KEYS`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 47-48
   :dedent:
