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

**************************************
Setting Up CMakePPLang for Development
**************************************

This page contains information to help developers new to CMakePPLang set up
the project to begin development.

Downloading the Source Code
===========================

During development, the latest version of CMakePPLang should be used.
CMakePPLang is `hosted on GitHub <CMakePPLang_src_>`__ and can be cloned to
your local system using Git_:

.. code-block:: bash

   git clone https://github.com/CMakePP/CMakePPLang.git

Building CMakePPLang
====================

CMakePPLang is built on top of and extends the `CMake language <CMake_>`__, so
"building" CMakePPLang is performed during CMake's configuration step. Once
the CMakePPLang source code has been downloaded, navigate into the new
``CMakePPLang`` directory and run the following command to "build" CMakePPLang:

For \*nix-based systems (including Mac OSX):

.. code-block:: bash

   cmake -H. -Bbuild -DBUILD_TESTING=ON

For Windows systems:

.. code-block:: bash

   cmake -S. -Bbuild -DBUILD_TESTING=ON

In these commands, ``-H`` and ``-S`` specify the top-level, root directory for
the project, called the "source directory" in CMake (not to be confused with a
"source code directory", commonly also called the "source directory"). In this
case, we are assuming that the current directory, ``.``, is the root directory
of the ``CMakePPLang`` repository. The directory where build artifacts will
appear is specified by ``-B``, meaning we are directing build artifacts to
``CMakePPLang/build``. Finally, ``-DBUILD_TESTING=ON`` enables unit testing on
CMakePPLang, which will be necessary for development. ``BUILD_TESTING``
defaults to ``OFF``, so this argument can be excluded if testing is not needed.

.. note::

   The build step usually required by projects using CMake is not required to
   build CMakePPLang itself, so it is not included in this section.

Running CMakePPLang Tests
=========================

Scripts to run the unit tests will be included in ``CMakePPLang/build`` with
the rest of the build artifacts. These scripts are run using CMake's test driver
program, CTest_. Navigate into the ``CMakePPLang/build`` directory and run
the following command to execute CMakePPLang's tests:

.. code-block:: bash

   ctest --output-on-failure

While ``ctest`` can be run with no arguments as well, it is usually useful to
run it with ``--output-on-failure``, since it will provide all of the output
from a failing test program instead of simply saying the test failed. After
the first run of the tests, it is also useful to include ``--rerun-failed``
to save time by skipping passing tests.

.. note::

   To learn more about writing unit tests for CMakePPLang, see
   :ref:`unit-testing-cmakepplang-functions`.

.. References

.. _CMake: https://cmake.org
.. _CTest: "https://cmake.org/cmake/help/book/mastering-cmake/chapter/Testing%20With%20CMake%20and%20CTest.html"
.. _CMakePPLang_src: https://github.com/CMakePP/CMakePPLang
.. _Git: https://git-scm.com/

