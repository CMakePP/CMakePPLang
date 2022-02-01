*****************
Obtaining CMakePP
*****************

This section details two ways of obtaining CMakePP for use in your build system.
The easiest way to use CMakePP in your project is to
:ref:`auto-downloading-cmakepp`.

.. TODO Docs on downloading source and manually buildig CMakePP
.. Alternatively you can choose to :ref:`downloading-cmakepp-manually`, which is
.. a bit more complicated.

.. _auto-downloading-cmakepp:

Automatically Downloading and Including CMakePP
===============================================

As a convenience to your users you can make it so that your build system
automatically downloads CMakePP and includes it. The easiest way to do this is
to put the following CMake script in a file ``cmake/get_cpp.cmake``:

.. code-block:: cmake

   include_guard()

   #[[
   # This function encapsulates the process of getting CMakePP using CMake's
   # FetchContent module. We have encapsulated it in a function so we can set
   # the options for its configure step without affecting the options for the
   # parent project's configure step (namely we do not want to build CMakePP's
   # unit tests).
   #]]
   function(get_cpp)

       # Store whether we are building tests or not, then turn off the tests
       set(build_testing_old "${BUILD_TESTING}")
       set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

       # Download CMakePP and bring it into scope
       include(FetchContent)
       FetchContent_Declare(
            cpp
            GIT_REPOSITORY https://github.com/CMakePP/CMakePackagingProject
       )
       FetchContent_MakeAvailable(cpp)

       # Restore the previous value
       set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)
   endfunction()

   # Call the function we just wrote to get CMakePP
   get_cpp()

   # Include CMakePP
   include(cpp/cpp)

and then in your top level ``CMakeLists.txt`` (assumed to be in the same
directory as the ``cmake`` directory you put ``get_cpp.cmake`` in) add the line:

.. code-block:: cmake

   include("${PROJECT_SOURCE_DIR}/cmake/get_cpp.cmake")

Your project will now download CMakePP automatically as part of the CMake
configuration. Users can use an already downloaded CMakePP by setting
``FETCHCONTENT_SOURCE_DIR_CPP`` to the directory of the pre-downloaded CMakePP.

.. TODO Docs on downloading source and manually building CMakePP
.. .. _downloading-cmakepp-manually:
..
.. Downloading the CMakePP Source and Building Manually
.. ====================================================
