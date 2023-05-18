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

********************
Language Conventions
********************

While you can always check the CMakePPLang documentation for how to 
use a function, CMakePPLang strives to also make it as easy as possible to
"guess" how to use functions. Key to this effort is understanding 
the various conventions underlying how CMakePPLang decides on APIs. This
chapter goes into more details regarding CMakePPLang conventions.

.. note::

   CMakePPLang strives to have no exceptions to these conventions. 
   If an exception exists (and it is not documented why it is an exception) 
   assume it is a bug and please file an `issue on GitHub 
   <https://github.com/CMakePP/CMakePPLang/issues>`__.

Namespaces
==========

Both CMake and CMakePP have a concept of variable scope, but neither have a 
namespace concept. The most straightforward way to introduce namespaces is to 
mangle a prefix onto function and variable names. CMakePPLang uses the prefix 
``cpp_`` for all commands that are part of the public API. This helps avoid 
conflicts with existing CMake commands, commands from other modules, and 
commands users may write. Similarly, CMakePPLang uses the prefix 
``_cpp_`` for "protected" commands and ``__cpp_`` for private commands. Note 
that commands in native CMake (as well as CMakePPLang) are case-insensitive
meaning ``CPP_`` (on a command) is still the same namespace as ``cpp_``.

In CMake, variables are case-sensitive. Native CMake tends to prefix their
configuration variables with ``CMAKE_``. CMakePPLang follows suit
with prefixes ``CMAKEPP_LANG_`` and ``__CMAKEPP_LANG`` respectively for public
and private configuration variables (``_CMAKEPP_LANG`` will be used if there
is ever need for a protected variable).

Function Argument Order
=======================

The signatures of functions found in CMakePPLang all follow the same
conventions when it comes to argument orders. For a non-member CMakePP function
taking :math:`m` arguments and returning :math:`n` values (:math:`n\le m`), the
first :math:`n` arguments will be the :math:`n` values returned by the function
and the remaining :math:`m-n` values will be the inputs. Neither CMake or
CMakePPLang make any attempt to distinguish the value of :math:`n` in the
signature and the only way to know if a value is input or output is to consult
the documentation (or read the source code).

.. note::

   Native CMake uses a mix of return positions. For example, the ``list()`` and
   ``string()`` commands tend to have the variable holding the result as the
   last argument. Note that for the various string hashing operations (*e.g.*
   ``string(MD5 ...)`` the variable for the return actually comes before the
   string to hash. Other functions, such as ``get_filename_component`` also put
   the return variable before the input arguments.

For all intents and purposes we can think of CMake's native ``list()`` and
``string()`` commands as defining APIs for calling member functions of ``list``
and ``string`` instances respectively. Within this view, a call like
``list(LENGTH <list_instance> <return_variable>)`` is calling the member
function named ``LENGTH`` of the provided ``list`` instance and returning the
result in the provided variable. CMakePPLang generalizes this convention to 
additional types, including user-defined classes.

For member functions associated with a type ``T``, CMakePPLang convention 
is to access the members via a function named ``T`` whose first argument is the
name of the member function and whose second argument is the instance the 
member is being called on (*e.g.*, the ``this`` instance in C++ or the ``self``
instance in Python). Arguments following the object instance obey the same 
ordering conventions as non-member functions (returns followed by input).
