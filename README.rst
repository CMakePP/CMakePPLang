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

*****************
Statement of Need
*****************

CMakePPLang defines the basic extensions of the CMake language which comprise
the CMakePP language. Think of this repo as being like the standard C++ library,
except for CMake.

*************************
Installation Instructions
*************************

CMakePPLang can be included in a CMake project by adding:

.. code-block:: cmake

   # Download CMakePP and bring it into scope
   include(FetchContent)
   FetchContent_Declare(
      cmakepp_lang
      GIT_REPOSITORY https://github.com/CMakePP/CMakePPLang
   )
   FetchContent_MakeAvailable(cmakepp_lang)

to your ``CMakeLists.txt`` file. CMakePPLang will then be downloaded as part
of the CMake configuration step. More detailed instructions, can be found
`here <https://cmakepp.github.io/CMakePPLang/getting_started/obtaining_cmakepplang.html>`__.

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
