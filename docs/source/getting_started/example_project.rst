.. _example-project-using-cmakepplang:

*********************************
Example Project using CMakePPLang
*********************************

This chapter demonstrates how to set up a project to use CMakePPLang, aiming to
be both a tutorial for new users setting up their first project using
CMakePPLang, as well as a quick reference for experienced users.

This project will create a `Greeter` class. This class will store a user's name
in a ``name`` attribute and greet them using a ``Greeter(hello`` member function.
The ``Greeter(hello`` function will print the following greeting,
"Hello <name>!", where ``<name>`` is the value of the ``name`` attribute.

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
   ├── cmake
   │   ├── get_cmakepp_lang.cmake
   │   ├── get_cmake_test.cmake
   │   └── greeter
   │       └── greeter_class.cmake
   ├── CMakeLists.txt
   ├── docs
   └── tests
      ├── CMakeLists.txt
      └── greeter
         └── test_greeter_class.cmake

The ``cmake`` directory is where most CMake and CMakePPLang code will exist.
This includes the code to fetch CMakePPLang, ``cmake/get_cmakepp_lang.cmake``.
The ``cmake/greeter`` subdirectory is used to contain the core code for this
project, effectively namespacing the code. This is where we will create our
``Greeter`` class.

The ``docs`` directory will house documentation written for the project and
generated API documentation. This step will not be covered in this example,
but see Sphinx and CMinx for methods to write and generate documentation for
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

Fetching CMakePPLang
====================

We will start by setting up the ability to get CMakePPLang automatically in
the project following the instructions at :ref:`auto-downloading-cmakepplang`.
First, add the following text to ``cmake/get_cmakepp_lang.cmake``:abbr:

.. code-block:: cmake

   include_guard()

   #[[
   # This function encapsulates the process of getting CMakePPLang using CMake's
   # FetchContent module. We have encapsulated it in a function so we can set
   # the options for its configure step without affecting the options for the
   # parent project's configure step (namely we do not want to build CMakePPLang's
   # unit tests).
   #]]
   function(get_cmakepp_lang)

      # Store whether we are building tests or not, then turn off the tests
      set(build_testing_old "${BUILD_TESTING}")
      set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

      # Download CMakePPLang and bring it into scope
      include(FetchContent)
      FetchContent_Declare(
         cmakepp_lang
         GIT_REPOSITORY https://github.com/CMakePP/CMakePPLang
      )
      FetchContent_MakeAvailable(cmakepp_lang)

      # Restore the previous value
      set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)
   endfunction()

   # Call the function we just wrote to get CMakePPLang
   get_cmakepp_lang()

   # Include CMakePPLang
   include(cmakepp_lang/cmakepp_lang)

Then, add the following line to the top-level ``CMakeLists.txt``:abbr:

.. code-block:: cmake

   include("${PROJECT_SOURCE_DIR}/cmake/get_cmakepp_lang.cmake")