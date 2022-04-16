.. _examples-utilities:

***************
Using Utilities
***************

This page provides examples of using utility functions available in the 
CMakePP language.

.. _examples-utilities-variable-equality:

Checking if Variables are Equal
===============================

We can use the ``cpp_equal`` function to check for equality between any two
variables, including objects and maps.

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_equality.cmake
   :lines: 6-21
   :dedent: 4

.. note::

  For native CMake types, such as booleans and integers, equality is defined as
  being the same string.

.. _examples-utilities-variable-serialization:

Serializing a Variable
======================

We can use ``cpp_serialize`` to serialize a variable into a JSON string:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_serialization.cmake
   :lines: 6-18
   :dedent: 4

Copying a Variable
==================

We can use the ``cpp_copy`` to create a deep copy of an existing variable
regardless of what type it is:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_copy.cmake
   :lines: 6-20
   :dedent: 4

Checking if Variable Contains a Value
=====================================

We can use the ``cpp_contains`` function to check if a certain value is
contained within another variable. The behavior changes depending on the type of
the variable we are examining.

Check if a Desc Contains a Substring
------------------------------------

We can use ``cpp_contains`` to check if a 
:ref:`features-types-quasi-cmake-desc` contains a substring:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_desc_contains_substring.cmake
   :lines: 6-22
   :dedent: 4

Check if a List Contains a Value
--------------------------------

We can use ``cpp_contains`` to check if a :ref:`features-types-cmake-list` 
contains a value:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_list_contains_value.cmake
   :lines: 6-22
   :dedent: 4

.. note::

  ``cpp_contains`` can take CMakePP objects and maps as search values.

Check if a Map Contains a Key
-----------------------------

We can use ``cpp_contains`` to check if a :ref:`features-types-cmakepp-map` 
contains a key:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_map_contains_key.cmake
   :lines: 6-19
   :dedent: 4

Determining the Type of a Variable
==================================

We can use ``cpp_type_of`` to get the :ref:`type <features-types>` of a 
variable or value:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/variable_type.cmake
   :lines: 6-10
   :dedent: 4

.. note::

  ``cpp_type_of`` works with CMakePP types as well as native CMake types.

Asserting a Condition
=====================

We can use ``cpp_assert`` to assert that a given value is true:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/assert.cmake
   :lines: 8-11, 16-18
   :dedent: 8

If an assert fails, it will stop the execution of the program and print the
provided assertion message along with the call stack from where the assertion
failed.

Checking if a File Exists
=========================

We can use ``cpp_file_exists`` to check if files exist:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/file_exists.cmake
   :lines: 6-20
   :dedent: 4

.. note::
   
   ``cpp_file_exists`` fails if passed a directory!

Manipulating Globals
====================

We can use ``cpp_set_global``, ``cpp_get_global``, and ``cpp_append_global`` to
get, set, and append global values:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/global_variables.cmake
   :lines: 6-14, 17-24
   :dedent: 4

Creating a Unique Identifier
============================

We can use ``cpp_unique_id`` to create a unique identifier:

.. literalinclude:: /../../tests/docs/source/getting_started/cmakepp_examples/utilities/create_unique_id.cmake
   :lines: 6-10
   :dedent: 4
