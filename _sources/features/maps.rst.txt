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

****
Maps
****

.. TODO: What is this "basic functionality" that is provided in these other
..       map implementations? We should explicitly state it instead of
..       assuming that the user has experience with one of these language's
..       equivalent structures (although the odds are pretty good that the
..       reader will have this experience).

CMakePPLang provides the ``map`` type for storing key-value pairs. 
The CMakePPLang ``map`` provides the same basic functionality as C++'s 
``std::map``, Python's ``dictionary``, or JavaScript's **Associative Array** 
structure. Users can use maps in their code wherever they see fit. A basic 
overview of the features is provided below.

Map Creation
============

The map constructor is used to create an empty map:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 11-12
   :dedent: 4

Optionally, key-value pairs can be provided to the map constructor. You must
simply add keys and their corresponding values as arguments passed to the
constructor:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 14-15
   :dedent: 4

Setting Values
==============

Values can be set by using the ``SET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 17-18
   :dedent: 4

Accessing Values
================

Values can be accessed using ``GET`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 20-21
   :dedent: 4

Appending Values
================

Values can be appended by using the ``APPEND`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 25-26
   :dedent: 4

Copying a Map
=============

Maps can be copied using the ``COPY`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 34-35
   :dedent: 4

Checking Equality of Maps
=========================

Map equality can be checked using the ``EQUAL`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 37-38
   :dedent: 4

Checking if a Map has a Key
===========================

Check whether the map contains a key with the ``HAS_KEY`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 42-43
   :dedent: 4

Getting a Map's Keys
====================

A list of a map's keys can be retrieved using the ``KEYS`` keyword:

.. literalinclude:: /../../tests/docs/source/features/maps.cmake
   :lines: 47-48
   :dedent: 4
