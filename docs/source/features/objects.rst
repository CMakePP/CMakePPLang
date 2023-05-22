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

*******
Objects
*******

The ``object`` class is the base class for all user-defined classes. This is the
class that defines the default implementations for the equality, copy, and
serialization functionalities. The member functions of ``object`` that implement
these features are called:

- ``_cpp_object_equal``
- ``_cpp_object_copy``
- ``_cpp_object_serialize``

Currently, these functions cannot be overridden in user-defined classes.

.. TODO: Uncomment this when overriding the methods is possible

.. The implementations of these functionalities within the object class are what
.. are called by the ``cpp_equal``, ``cpp_copy``, and ``cpp_serialize`` utilities.
.. It is useful to note that these member functions may be **overridden** by any
.. class (since all classes inherit from ``object``). Examples of overriding
.. these methods are provided in
.. :ref:`examples-classes-overriding-object-methods`.

.. Other than the above, the object class is not assumed to be of much interest
.. to most users of CMakePPLang.
