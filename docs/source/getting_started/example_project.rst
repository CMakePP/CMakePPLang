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

.. _example-project-using-cmakepplang:

*********************************
Example Project using CMakePPLang
*********************************

This chapter demonstrates how to set up a project to use CMakePPLang, aiming to
be both a tutorial for new users setting up their first project using
CMakePPLang, as well as a quick reference for experienced users.

This project will create a `Greeter` class. This class will store a user's name
in a ``name`` attribute and greet them using a ``Greeter(hello ...)`` member
function. The ``Greeter(hello ...)`` function will print the following
greeting, "Hello, <name>!", where ``<name>`` is the value of the ``name``
attribute.

.. note::

   The full example project can be found under ``examples/cmakepplang_example``
   to check your work or follow along when creating a new project is not
   possible/desired.

Project Layout
==============

This project will be a simple layout with a top-level ``CMakeLists.txt`` file,
a ``cmake`` subdirectory where CMake source code will reside, and a ``tests``
directory where the code will be tested. If following along, create these
files and directories now, but leave the files blank. We will populate them in
later sections.

The layout will look like this:

.. code-block:: bash

   .
   ├── cmake/
   │   ├── get_cmakepp_lang.cmake
   │   ├── get_cmake_test.cmake
   │   └── greeter/
   │       └── greeter_class.cmake
   ├── CMakeLists.txt
   ├── docs/
   └── tests/
      ├── CMakeLists.txt
      └── greeter/
         └── test_greeter_class.cmake

The ``cmake`` directory is where most CMake and CMakePPLang code will exist.
This includes the code to fetch CMakePPLang, ``cmake/get_cmakepp_lang.cmake``.
The ``cmake/greeter`` subdirectory is used to contain the core code for this
project, effectively namespacing the code. This is where we will create our
``Greeter`` class.

The ``docs`` directory will house documentation written for the project and
generated API documentation. This step will not be covered in this example,
but see Sphinx_ and CMinx_ for methods to write and generate documentation for
your project.

The ``tests`` directory contains unit testing for your CMake and CMakePPLang
code, tested through CMakeTest. This directory should mirror the ``cmake``
directory structure, with test files including the ``test_`` prefix. We will
test our ``Greeter`` class here.

Finally, a ``CMakeLists.txt`` file at the root of the project will be the
entry point for the CMake project. Subdirectories sometimes contain additional
``CMakeLists.txt`` files for code specific to a specific directory's function.
In this project, there is an additional ``CMakeLists.txt`` that will fetch
``CMakeTest`` and include the tests to be run.

Initial CMake Boilerplate
=========================

All CMake projects require that a minimum CMake version be set with
``cmake_minimum_required()`` and a project must be defined with ``project()``.
Additionally, it is useful to add a toggle for whether to build the project
tests or not that the user can change as needed. We add the
``option(BUILD_TESTING`` call to add this option.

.. literalinclude:: /../../examples/cmakepplang_example/CMakeLists.txt
   :lines: 1-4

Fetching CMakePPLang
====================

We will start by setting up the ability to get CMakePPLang automatically in
the project following the instructions at :ref:`auto-downloading-cmakepplang`.
First, add the following text to ``cmake/get_cmakepp_lang.cmake``:

.. literalinclude:: /../../tests/docs/source/getting_started/obtaining_cmakepplang_get_cmakepp_lang.cmake

Then, add the following line at the bottom of the top-level
``CMakeLists.txt`` created earlier:

.. literalinclude:: /../../examples/cmakepplang_example/CMakeLists.txt
   :lines: 6-9

Defining the Class
==================

Now we need to define the ``Greeter`` class with the ``name`` attribute and
``hello`` member function. Create a ``cmake/greeter/greeter_class.cmake``
file and add the following text:

.. literalinclude:: /../../examples/cmakepplang_example/cmake/greeter/greeter_class.cmake

An example of using the ``Greeter`` class can then be added to the bottom of
the top-level ``CMakeLists.txt`` file:

.. literalinclude:: /../../examples/cmakepplang_example/CMakeLists.txt
   :lines: 11-28

Testing the Class
=================

CMakeTest is going to be used to test the ``Greeter`` class we just wrote, so
we need to get CMakeTest similarly to how we automatically got CMakePPLang.
Add the following text to ``cmake/get_cmake_test.cmake``:

.. literalinclude:: /../../examples/cmakepplang_example/cmake/get_cmake_test.cmake

Next is to create the test for ``Greeter`` by adding the following text to
``tests/greeter/test_greeter_class.cmake``, testing the output of the
``Greeter(hello ...)`` method:

.. literalinclude:: /../../examples/cmakepplang_example/tests/greeter/test_greeter_class.cmake

Then, we have to add the tests to the project. At the bottom of the
top-level ``CMakeLists.txt``, we add the final part to add the tests directory
and allow the tests to be toggled on and off with the ``BUILD_TESTING`` option:

.. literalinclude:: /../../examples/cmakepplang_example/CMakeLists.txt
   :lines: 30-34

Finally, we can complete adding the tests by populating ``tests/CMakeLists.txt``
to get CMakeTest and add the ``tests/greeter`` test directory for CMakeTest:

.. literalinclude:: /../../examples/cmakepplang_example/tests/CMakeLists.txt

Building the Project
====================

Now that we have a complete project, it can be built with CMake after
navigating to the top of the project directory, which we will refer to here
as ``PROJECT_ROOT``. In a terminal, run the following command for your system:

For Unix- or Linux-based systems (including Mac OSX):

.. code-block:: bash

   cmake -H. -Bbuild -DBUILD_TESTING=ON

For Windows systems:

.. code-block:: batch

   cmake -S. -Bbuild -DBUILD_TESTING=ON

In these commands, ``-H`` and ``-S`` specify the top-level, root directory for
the project, called the "source directory" in CMake (not to be confused with a
"source code directory", commonly also called the "source directory"). In this
case, we are assuming that the current directory, ``.``, is ``PROJECT_ROOT``.
The directory where build artifacts will appear is specified by ``-B``,
meaning we are directing build artefacts to ``PROJECT_ROOT/build``. Finally,
``-DBUILD_TESTING=ON`` enables unit testing on CMakePPLang, which will be
necessary for development. ``BUILD_TESTING`` defaults to ``OFF``, so this
argument can be excluded if testing is not needed.

.. note::

   Since CMakePPLang is built during the CMake configuration step, the build step
   is usually not needed. However, if it becomes necessary, the build step can
   be run with:

   .. code-block:: bash

      cmake --build build

Running the Tests
=================

If tests were built using the ``BUILD_TESTING=ON`` option, then unit tests from
the build will be included in the ``build`` directory generated above. These
tests are run using CMake's test driver program, CTest_. Navigate into the
``build`` directory and run the following command to execute the tests:

.. code-block:: bash

   ctest --output-on-failure

While ``ctest`` can be run with no arguments as well, it is usually useful to
run it with ``--output-on-failure``, since it will provide all of the output
from a failing test program instead of simply saying the test failed. After
the first run of the tests, it is also useful to include ``--rerun-failed``
to save time by skipping passing tests.

.. References

.. _CMinx: https://github.com/CMakePP/CMinx
.. _CTest: "https://cmake.org/cmake/help/book/mastering-cmake/chapter/Testing%20With%20CMake%20and%20CTest.html"
.. _Sphinx: https://www.sphinx-doc.org/en/master/
