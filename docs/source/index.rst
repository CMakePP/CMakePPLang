###########
CMakePPCore
###########

At the heart of the CMake Packaging Project is the CMakePP language. The CMakePP
language should be considered a new language compared to CMake. In particular,
CMakePP has different coding practices, paradigms, and standards than the native
CMake language. That said CMakePP is written entirely in terms of native CMake
so that it should always be possible to write native CMake code in a project
that uses CMakePP, whereas the opposite will not be true. By means of analogy,
CMakePP is a bit like C++ and CMake is like C. While C++ is (basically)
backwards compatible with C, one can not use C++ in C code.

.. toctree::
   :maxdepth: 2

   developer/index
