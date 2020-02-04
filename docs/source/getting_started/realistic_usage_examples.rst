**********************************
Realistic Usage Examples
**********************************

With CMakePP the build system for a C++ library can be as easy as:

.. code-block:: cmake

   cmake_minimum_required(VERSION 3.14)
   project(your_first_cmakepp_project VERSION 1.0.0)
   include(cpp/cpp)

   cpp_add_library(
       your_library_name
       SOURCE_DIR /path/to/your/library/source/dir
       INCLUDE_DIR /path/to/your/library/include/dir
   )

The above snippet will automatically find your library's header and source
files, create and configure a CMake build target for your library, generate the
packaging files for your library, and configure an install target. However, the
real power of CMakePP is that it makes it easy to integrate dependencies into
your project's build system. For example, if the library from the previous
example depends on a dependency `name_of_dependency`:

.. code-block:: cmake

   cmake_minimum_required(VERSION 3.14)
   project(your_first_cmakepp_project VERSION 1.0.0)
   include(cpp/cpp)

   cpp_find_or_build_dependency(
       name_of_dependency
       URL github.com/an_organization/the_dependency
       BUILD_TARGET the_dependency
       FIND_TARGET  the_dependency::the_dependency
   )

   cpp_add_library(
       your_library_name
       SOURCE_DIR /path/to/your/library/source/dir
       INCLUDE_DIR /path/to/your/library/include/dir
       DEPENDS name_of_dependency
   )

This relatively small snippet will properly look for the dependency using
CMake's `find_package` command. If the dependency is not found, CMakePP will
then build it using CMake's `FetchContent` module.
