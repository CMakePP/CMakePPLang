..
   Copyright 2023 CMakePP

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

###########
CMakePPLang
###########

.. image:: https://github.com/CMakePP/CMakePPLang/workflows/CMakePPLang%20Unit%20Tests/badge.svg
   :target: https://github.com/CMakePP/CMakePPLang/workflows/CMakePPLang%20Unit%20Tests/badge.svg

.. image:: https://github.com/CMakePP/CMakePPLang/actions/workflows/deploy_docs.yml/badge.svg?branch=master
   :target: https://github.com/CMakePP/CMakePPLang/actions/workflows/deploy_docs.yml/badge.svg?branch=master

.. image:: https://joss.theoj.org/papers/10.21105/joss.05711/status.svg
   :target: https://doi.org/10.21105/joss.05711

CMakePPLang defines the basic extensions of the CMake language which comprise
the CMakePP language. Think of this repo as being like the standard C++ library,
except for CMake.

*****************
Statement of Need
*****************

CMake is arguably the *de facto* build tool for building C and C++ software
packages of moderate to large size. Anecdotally we have observed that, as the
size of a package grows, so too does the complexity of its build system.
Object-oriented programming (OOP) is a popular and established technique for
managing complexity in software and we assert that OOP can also be used to
manage the complexity of the build system. Unfortunately, CMake is a functional
language with no OOP support. Given the ubiquitous nature of CMake-based build
systems and tools, the ideal OOP solution is to introduce OOP into CMake via a
mechanism which preserves backwards compatibility with standard CMake.

We are not the first to suggest such a solution. To that end, Tobias Becker
created the [CMake++](https://github.com/toeb/cmakepp) (formally called
cmake-oo) module, which contains a number of CMake extensions including support
for OOP. As of this writing, CMake++ seems to be an abandoned project with only
two commits since July of 2017, both in 2021. As far as we know there are no
other OOP CMake solutions out there.

Before creating CMakePPLang, we considered whether or not to attempt to
resurrect CMake++. Looking through the CMake++ repo we were able to find a
decent amount of user documentation, but little to no API or developer
documentation. Ultimately, we decided that the effort needed to understand
CMake++, document it with [CMinx](https://github.com/CMakePP/CMinx), and test
it with [CMakeTest](https://github.com/CMakePP/CMakeTest) would be greater than
writing a new, ground-up, OOP extension to CMake, and CMakePPLang was born.

*************************
Installation Instructions
*************************

CMakePPLang is distributed as a CMake module and can thus be included in CMake
projects simply by adding:

.. code-block:: cmake

   # Download CMakePP and bring it into scope
   include(FetchContent)
   FetchContent_Declare(
      cmakepp_lang
      GIT_REPOSITORY https://github.com/CMakePP/CMakePPLang
   )
   FetchContent_MakeAvailable(cmakepp_lang)

to your ``CMakeLists.txt`` file. CMakePPLang will then be downloaded as part
of your project's CMake configuration step. More detailed instructions, can be
found
`here <https://cmakepp.github.io/CMakePPLang/getting_started/obtaining_cmakepplang.html>`__ including
information about pinning a specific version of CMakePPLang.

If you would like to independently verify CMakePPLang works please see the
instructions for running the test suite located in the developer documentation
(`link <https://cmakepp.github.io/CMakePPLang/developer/initial_setup.html>`__).

*************
Example Usage
*************

Once CMakePPLang is installed, it can be used in a CMake file by including it
with:

.. code-block:: cmake

   include(cmakepp_lang/cmakepp_lang)

Here we define an ``Automobile`` class with the ``color`` attribute and a
``start()`` member function:

.. code-block:: cmake

   # Begin class definition
   cpp_class(Automobile)

      # Define an attribute "color" with the value "red"
      cpp_attr(Automobile color red)

      # Define a function "start" that prints a message
      cpp_member(start Automobile)
      function("${start}" self)
         message("Vroom! I have started my engine.")
      endfunction()

   # End class definition
   cpp_end_class()

Now, an instance of this class can be created to get the value of the ``color``
attribute and call ``start()``:

.. code-block:: cmake

   # Call the default class constructor (CTOR) to create an instance of
   # Automobile called "my_auto"
   Automobile(CTOR my_auto)

   # Access the "color" attribute and save it to the var "my_autos_color"
   Automobile(GET "${my_auto}" my_autos_color color)

   # Print out the value of the var "my_autos_color"
   message("The color of my_auto is: ${my_autos_color}")

   # Output: The color of my_auto is: red

   # Call the function using our Automobile instance
   Automobile(start "${my_auto}")

   # Output: Vroom! I have started my engine.

A complete list of CMakePPLang examples can be found
`here <https://cmakepp.github.io/CMakePPLang/getting_started/cmakepp_examples/index.html>`__.

*****************
API Documentation
*****************

Full API documentation can be found
`here <https://cmakepp.github.io/CMakePPLang/developer/index.html#cmakepplang-api>`__.

******************
Release Versioning
******************

CMakePPLang uses `semantic versioning <https://semver.org/>`__ for releases.
Although CMakePPLang is built on top of CMake, CMakePPLang mostly relies on
fairly fundamental features of the CMake language, so it is versioned
independently of CMake. A more complete discussion of CMakePPLang versioning
considerations can be found `here <https://cmakepp.github.io/CMakePPLang/versioning.html>`__

************
Contributing
************

In short, we try to be a welcoming community. If you have questions,
suggestions, bug reports, *etc.* open an issue and we will address them
as soon as possible. If you want to contribute code, that's even better. We
recommend you start a draft PR early in the process so we know the contribution
is coming and can help you along the way.

CMakePPLang is part of the CMakePP organization, whose contributing guidelines
can be found `here <https://cmakepp.github.io/.github/code_of_conduct.html>`__.

Developer documentation can be found
`here <https://cmakepp.github.io/CMakePPLang/developer/index.html>`__ to help
get started with CMakePPLang development.
