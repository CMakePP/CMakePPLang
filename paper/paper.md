# CMakePPLang

## Summary



## Statement of Need

CMake is small, extensible, and exceeds at generating build systems for many combinations of platforms, compilers, and build configurations.

CMake has become the *de facto* standard tool for building C, C++, and Fortran
programs of moderate to large size. As the size of a project increases, the
complexity of the CMake code to build it tends to also increase. Object-
oriented programming excels at managing large, complex code bases, and there
is an increasing need for this in the CMake language.

As more tooling is built around CMake to make building projects with CMake
easier and less error prone, these tools will need to be designed in a
maintainable and testable way. Object-oriented programming excels at creating
maintainable code if done correctly. Complexity of builds will also increase as
we move toward heterogeneous systems, requiring programs to leverage a
combination of CPUs, GPUs, and other accelerator hardware.

Tobias Becker recognized these issues and wrote a purely object-oriented
language on top of CMake, called CMake++ (formerly oo-cmake).
This project appears to have been abandoned, as there have only been two
commits since July 2017, both in 2021.


