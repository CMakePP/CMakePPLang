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

###########
CMakePPLang
###########

The `CMakePP organization`_ is committed to making the act of packaging projects
with CMake easier through a variety of tools that form a CMake development
ecosystem. As complexity is added to the various CMakePP tools, as well as other
third-party tools, the need for more capabilities in the CMake language to 
enable the development of more maintainable and testable code becomes apparent.
Object-oriented programming is often thought as synonymous with maintainability
in programming, however, CMake is a primarily function-based language.
CMake is also weakly, dynamically typed, as all "types" in CMake are strings that
are interpreted as different types when needed. A strongly, statically typed
language would allow mistakes to be caught before the program is run, reducing
the risk of releasing a bugged program.

At the heart of the CMakePP ecosystem is the CMakePP language, CMakePPLang.
CMakePPLang is an object-oriented extension to the CMake language providing
strong, static typing written entirely using the original CMake language.
CMakePPLang has different coding practices, paradigms, and standards than
the native CMake language, much in the same way that C++ coding differs
from C coding despite some level of interoperability. CMakePPLang is also
designed with a C++-like feel to aid C++ programmers in using the language.

This documentation is primarily meant to introduce users to the CMakePP
language. It includes some basic usage examples, an overview of the features and
conventions of the language, auto-generated API documentation, notes on
debugging code written in CMakePPLang, as well as notes for developers.

.. toctree::
   :maxdepth: 2

   getting_started/index
   features/index
   conventions
   api/index
   debugging
   developer/index
   Contributing <https://cmakepp.github.io/.github/code_of_conduct.html>
   Authors <authors>
   license
   versioning

.. References:

.. _CMakePP organization: https://github.com/CMakePP
