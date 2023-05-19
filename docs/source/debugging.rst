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

.. _debugging:

*************************************
Debugging Code Written in CMakePPLang
*************************************

Native CMake has limited debugging capabilities, which are limited to printing
variables out and very verbose printing of every line that is executed by the
interpreter. While designing CMakePPLang, we attempted to provide more robust
programming error checking and debugging features. These features come at a
computational cost, so they should only be used to debug/unit test your build
systems.

.. _debugging-basics:

Debugging Basics
================

The variable ``CMAKEPP_LANG_DEBUG_MODE`` can be used to cause all CMakePPLang
functions to run in debug mode. If you are familiar with the C/C++ preprocessor
macro definition ``NDEBUG`` it's the same idea, without the odd negative logic.
Verbose logging and extra error checks, like type and bounds checks, are only
done when ``CMAKEPP_LANG_DEBUG_MODE`` is defined and set to a true value.

.. warning::

   There can be significant computational overhead associated with running your
   build system in debug mode, so your releases should **NOT** be in debug mode.
   As a rule-of-thumb, only enable debug mode when you are debugging or to
   ensure that you didn't make any programming mistakes.
