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

*********************
Obtaining CMakePPLang
*********************

This section details two ways of obtaining CMakePPLang for use in your build 
system. The easiest way to use the CMakePP language in your project is
:ref:`auto-downloading-cmakepplang`.

Alternatively you can choose :ref:`manually-downloading-cmakepplang`, which is
a bit more complicated.

.. _auto-downloading-cmakepplang:

Automatically Downloading and Including CMakePPLang
===================================================

As a convenience to your users you can make it so that your build system
automatically downloads CMakePPLang and includes it. The easiest way to do
this is to put the following CMake script in a file
``PROJECT_ROOT/cmake/get_cmakepp_lang.cmake``:

.. literalinclude:: /../../tests/docs/source/getting_started/obtaining_cmakepplang_get_cmakepp_lang.cmake

and then in your top level ``CMakeLists.txt`` (assumed to be in the same
directory as the ``cmake`` directory you put ``get_cmakepp_lang.cmake`` in)
add the line:

.. code-block:: cmake

   include("${PROJECT_SOURCE_DIR}/cmake/get_cmakepp_lang.cmake")

Your project will now download CMakePP automatically as part of the CMake
configuration.

.. _manually-downloading-cmakepplang:

Downloading CMakePPLang and Building Manually
=============================================

Although convenient, automatically downloading and including CMakePPLang
is not as useful when attempting to test local changes made to CMakePPLang.
In this scenario, CMakePPLang can be manually downloaded from GitHub either
through the web interface or by using the ``git clone`` command:

.. code-block:: bash

   git clone https://github.com/CMakePP/CMakePPLang.git

Once CMakePPLang has been downloaded and changes have been made, set up your
project that uses CMakePPLang as described in :ref:`auto-downloading-cmakepplang`.
Your project will then use your local CMakePPLang if you set
``FETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG`` to the directory containing your local
changes. This can be set in a ``toolchain.cmake`` file, directly in a
``CMakeLists.txt`` file (although it is not recommended to hard-code local
paths into your CMake files), or as an argument to the CMake configure step
with ``-DFETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG=<local_path>``.
