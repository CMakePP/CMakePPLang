*********************
Obtaining CMakePPLang
*********************

This section details two ways of obtaining CMakePPLang for use in your build 
system. The easiest way to use the CMakePP language in your project is to
:ref:`auto-downloading-cmakepp`.

.. TODO Docs on downloading source and manually buildig CMakePP
.. Alternatively you can choose to :ref:`downloading-cmakepp-manually`, which is
.. a bit more complicated.

.. _auto-downloading-cmakepp:

Automatically Downloading and Including CMakePPLang
===================================================

As a convenience to your users you can make it so that your build system
automatically downloads CMakePP and includes it. The easiest way to do this is
to put the following CMake script in a file ``cmake/get_cpp.cmake``:

.. literalinclude:: /../../tests/docs/source/getting_started/obtaining_cmakepp_get_cpp.cmake

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
