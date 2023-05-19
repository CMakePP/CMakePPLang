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

******************
Exception Handling
******************

CMakePPLang provides commands for handling exceptions. Users can use 
the ``cpp_catch`` command to declare an exception type and a handler function 
for that exception type. Users can then use the ``cpp_try`` to initiate a try 
block and ``cpp_end_try_catch`` to end a try block. Anywhere within that try 
block, an exception can be thrown using the ``cpp_raise`` command.

Basic Try-Catch Block
=====================

A basic try-catch block for an exception type named ``FileNotFound`` looks like
this:

.. literalinclude:: /../../tests/docs/source/features/exceptions/basic_try_catch.cmake
   :lines: 6-17
   :dedent: 4

Handling Multiple Types of Exceptions
=====================================

Multiple exception handlers for different types of exceptions can be declared:

.. literalinclude:: /../../tests/docs/source/features/exceptions/handle_multiple_exception_types.cmake
   :lines: 6-20, 24-26
   :dedent: 4

Nested Try-Catch Blocks
=======================

If a try-catch block for an exception type is nested within a try-catch block
of the same exception type, the handler declared by the deepest try-catch
block will be called:

.. literalinclude:: /../../tests/docs/source/features/exceptions/nested_try_catch.cmake
   :lines: 6-26, 29-31
   :dedent: 4

Adding Exception Handler for All Exceptions
===========================================

A general exception handler that catches all exceptions that don't have a
specific handler declared for their exception type can be declared by using the
``ALL_EXCEPTIONS`` keyword in the try-catch block:

.. literalinclude:: /../../tests/docs/source/features/exceptions/handle_all_exceptions.cmake
   :lines: 6-15, 18-19
   :dedent: 4
