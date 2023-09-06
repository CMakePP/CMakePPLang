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

Your project will now download CMakePPLang automatically as part of the CMake
configuration.

.. _version-pinning:

Pinning a CMakePPLang Version
-----------------------------

Sometimes bugs may be found in a particular version of CMakePPLang (that will
hopefully be fixed quickly in the next version!). In this case, it is useful
to pin a previous version so you can continue your work uninterupted. To pin
a specific version of CMakePPLang, use the ``GIT_TAG <version_tag>`` argument
for ``FetchContent_Declare()``. For example, to pin version ``v1.0.2``, use
the following ``FetchContent_Declare()`` call:

.. code-block:: cmake

   FetchContent_Declare(
       cmakepp_lang
       GIT_REPOSITORY https://github.com/CMakePP/CMakePPLang
       GIT_TAG v1.0.2
   )

.. _manually-downloading-cmakepplang:

Downloading CMakePPLang and Building Manually
=============================================

Although convenient, automatically downloading and including CMakePPLang
is not as useful when attempting to test local changes made to CMakePPLang.
In this scenario, CMakePPLang can be manually downloaded from GitHub either
through the web interface or by using the ``git clone`` command:

.. code-block:: bash

   git clone https://github.com/CMakePP/CMakePPLang.git

Once CMakePPLang has been downloaded and changes have been made, create or
navigate to your project that relies on the new CMakePPLang functionality,
which we will refer to here as ``ExampleProject``. Create a CMake file to
fetch CMakePPLang in ``ExampleProject`` that will use CMakePPLang at
``ExampleProject/cmake/get_cmakepp_lang.cmake``, and add the following text:

.. literalinclude:: /../../tests/docs/source/getting_started/obtaining_cmakepplang_get_cmakepp_lang.cmake

Then, in the top-level ``CMakeLists.txt`` at the root of ``ExampleProject``,
add the following line before any code using CMakePPLang:

.. code-block:: cmake

   include("${PROJECT_SOURCE_DIR}/cmake/get_cmakepp_lang.cmake")

So far, ``ExampleProject`` is set up to automatically fetch the latest version
of CMakePPLang from https://github.com/CMakePP/CMakePPLang, but we want to use
your modified, local version. ``ExampleProject`` can be instructed to use your
local CMakePPLang if you set the ``FETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG``
variable to the directory containing your modified, local version. There are
multiple ways to set the ``FETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG`` variable,
ranked here from most recommended to least recommended:

#. Set the value in a `CMake toolchain file`_ (``toolchain.cmake``). You can
   specify for your project to use this toolchain by adding one of the
   following arguments to your CMake configure step command: 
   ``-DCMAKE_TOOLCHAIN_FILE=path/to/file`` or
   ``--toolchain /path/to/file``.

#. Set the value as an argument to the CMake configure command
   with the argument: ``-DFETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG=path/to/
   cmakepp_lang``

#. Set the value directly in a ``CMakeLists.txt`` file. However, since CMake
   build files should be portable to different systems, it is strongly
   discouraged to hard-code local paths into your CMake files.

Your project will now use your modified, local version of CMakePPLang during
CMake configuration.

.. References:

.. _CMake toolchain file: https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html
